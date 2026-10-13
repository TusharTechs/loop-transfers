import 'package:flutter/material.dart';
import 'package:loop_client/loop_client.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/place_picker.dart';

/// Create or edit a transfer request. Used as the first-run step and pushed
/// as a page for edits and additional exchanges.
class RequestScreen extends StatefulWidget {
  final MyListing? editing;
  final bool asPage;
  const RequestScreen({super.key, this.editing, this.asPage = false});

  static Future<void> open(BuildContext context, {MyListing? editing}) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(editing == null ? 'New request' : 'Edit request')),
          body: RequestScreen(editing: editing, asPage: true),
        ),
      ));

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _WishDraft {
  Place? place;
  int radiusKm;
  _WishDraft({this.place, this.radiusKm = 0});
}

class _RequestScreenState extends State<RequestScreen> {
  List<ExchangeSummary>? _exchanges;
  Exchange? _exchange;
  Place? _current;
  final _title = TextEditingController();
  int _years = 3;
  final _wishes = <_WishDraft>[_WishDraft()];
  bool _saving = false;
  String? _error;

  static const _radii = [0, 25, 50, 100];

  @override
  void initState() {
    super.initState();
    final e = widget.editing;
    if (e != null) {
      _exchange = e.exchange;
      _current = e.listing.currentPlace;
      _title.text = e.listing.postTitle;
      _years = e.listing.yearsInPost;
      _wishes
        ..clear()
        ..addAll([
          for (final w in e.wishes) _WishDraft(place: w.place, radiusKm: w.radiusKm),
        ]);
    }
    _load();
  }

  Future<void> _load() async {
    try {
      final list = await client.exchange.list();
      final taken = {
        for (final l in AppState.instance.listings)
          if (l.listing.id != widget.editing?.listing.id) l.exchange.id,
      };
      setState(() => _exchanges = [
            for (final s in list)
              if (!taken.contains(s.exchange.id)) s,
          ]);
    } catch (e) {
      setState(() => _error = describeError(e));
    }
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  bool get _valid =>
      _exchange != null &&
      _current != null &&
      _title.text.trim().isNotEmpty &&
      _wishes.any((w) => w.place != null);

  Future<void> _submit() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final saved = await client.listing.save(
        exchangeId: _exchange!.id!,
        currentPlaceId: _current!.id!,
        postTitle: _title.text.trim(),
        yearsInPost: _years,
        wishes: [
          for (final w in _wishes)
            if (w.place != null) WishInput(placeId: w.place!.id!, radiusKm: w.radiusKm),
        ],
      );
      AppState.instance.replaceListing(saved);
      if (widget.asPage && mounted) Navigator.of(context).pop();
      if (mounted) toast(context, 'Request saved — Loop is searching for you.');
    } catch (e) {
      setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _pickExchange(Exchange e) {
    setState(() {
      if (_exchange?.id != e.id) {
        _current = null;
        for (final w in _wishes) {
          w.place = null;
        }
      }
      _exchange = e;
      if (_title.text.isEmpty) _title.text = e.cadre;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final editing = widget.editing != null;
    return SingleChildScrollView(
      child: PageBody(
        maxWidth: 760,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36),
            if (!widget.asPage) ...[
              const Eyebrow('Step 2 of 2'),
              const SizedBox(height: 10),
              Text('Where do you want to go?', style: context.text.displaySmall),
              const SizedBox(height: 10),
              Text(
                'Tell Loop where you are posted and where you would happily move. '
                'Add a radius to say "anywhere near" — more flexibility means more '
                'loops.',
                style: context.text.bodyLarge!.copyWith(height: 1.5),
              ),
              const SizedBox(height: 32),
            ],
            _Section(
              number: 1,
              title: 'Your exchange',
              hint: 'Swaps are only legal within the same cadre and post.',
              child: _exchanges == null
                  ? const Padding(padding: EdgeInsets.all(20), child: Loading())
                  : Column(
                      children: [
                        for (final s in _exchanges!)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _ExchangeOption(
                              summary: s,
                              selected: _exchange?.id == s.exchange.id,
                              enabled: !editing,
                              onTap: () => _pickExchange(s.exchange),
                            ),
                          ),
                      ],
                    ),
            ),
            if (_exchange != null) ...[
              _Section(
                number: 2,
                title: 'Where you are posted now',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PlacePicker(
                      label: 'District',
                      state: _exchange!.state,
                      value: _current,
                      onSelected: (p) => setState(() => _current = p),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _title,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        labelText: 'Your post',
                        hintText: 'e.g. Primary Teacher, ZP School Kharadi',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Years in this post', style: context.text.bodyMedium),
                        const Spacer(),
                        IconButton.outlined(
                          onPressed: _years > 0 ? () => setState(() => _years--) : null,
                          icon: const Icon(Icons.remove, size: 18),
                        ),
                        SizedBox(
                          width: 44,
                          child: Text('$_years',
                              textAlign: TextAlign.center, style: mono(context, size: 18)),
                        ),
                        IconButton.outlined(
                          onPressed: _years < 45 ? () => setState(() => _years++) : null,
                          icon: const Icon(Icons.add, size: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _Section(
                number: 3,
                title: 'Places you would move to',
                hint: 'In order of preference. Up to five.',
                child: Column(
                  children: [
                    for (var i = 0; i < _wishes.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Panel(
                          padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(ordinal(i), style: context.text.labelMedium!.copyWith(color: c.loop)),
                                  const Spacer(),
                                  if (i > 0)
                                    IconButton(
                                      tooltip: 'Move up',
                                      icon: const Icon(Icons.arrow_upward, size: 18),
                                      onPressed: () => setState(() {
                                        final w = _wishes.removeAt(i);
                                        _wishes.insert(i - 1, w);
                                      }),
                                    ),
                                  if (_wishes.length > 1)
                                    IconButton(
                                      tooltip: 'Remove',
                                      icon: const Icon(Icons.close, size: 18),
                                      onPressed: () => setState(() => _wishes.removeAt(i)),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: PlacePicker(
                                  label: 'District',
                                  state: _exchange!.state,
                                  value: _wishes[i].place,
                                  onSelected: (p) => setState(() => _wishes[i].place = p),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final r in _radii)
                                    ChoiceChip(
                                      label: Text(r == 0 ? 'Exactly here' : 'Within $r km'),
                                      selected: _wishes[i].radiusKm == r,
                                      onSelected: (_) => setState(() => _wishes[i].radiusKm = r),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_wishes.length < 5)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => setState(() => _wishes.add(_WishDraft())),
                          icon: const Icon(Icons.add),
                          label: const Text('Add another place'),
                        ),
                      ),
                  ],
                ),
              ),
            ],
            if (_error != null) ...[
              Text(_error!, style: context.text.bodyMedium!.copyWith(color: c.declined)),
              const SizedBox(height: 14),
            ],
            FilledButton.icon(
              onPressed: _valid && !_saving ? _submit : null,
              icon: const Icon(Icons.all_inclusive, size: 18),
              label: Text(_saving
                  ? 'Saving…'
                  : editing
                      ? 'Save and search again'
                      : 'Start searching for loops'),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final int number;
  final String title;
  final String? hint;
  final Widget child;
  const _Section({required this.number, required this.title, required this.child, this.hint});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: context.colors.ink, shape: BoxShape.circle),
                  child: Text('$number',
                      style: mono(context, size: 13, color: context.colors.paper)),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: context.text.headlineSmall)),
              ],
            ),
            if (hint != null)
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 4),
                child: Text(hint!, style: context.text.bodySmall),
              ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      );
}

class _ExchangeOption extends StatelessWidget {
  final ExchangeSummary summary;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;
  const _ExchangeOption({
    required this.summary,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final e = summary.exchange;
    return Panel(
      onTap: enabled ? onTap : null,
      color: selected ? c.loopSoft : null,
      borderColor: selected ? c.loop : null,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? c.loop : c.muted,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(e.name, style: context.text.titleMedium),
                    if (e.isSandbox)
                      Pill('Try it · answers in seconds', color: c.loop, filled: true)
                    else if (e.isSimulated)
                      Pill('Demo · simulated members', color: c.muted),
                  ],
                ),
                const SizedBox(height: 4),
                Text(e.description, style: context.text.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${summary.activeListings}', style: mono(context, size: 16)),
              Text('searching', style: context.text.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
