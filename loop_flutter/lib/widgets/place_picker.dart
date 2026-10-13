import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loop_client/loop_client.dart';

import '../client.dart';
import '../theme.dart';

/// District search backed by the server, optionally limited to one state.
class PlacePicker extends StatefulWidget {
  final String label;
  final String? state;
  final Place? value;
  final ValueChanged<Place> onSelected;

  const PlacePicker({
    super.key,
    required this.label,
    required this.onSelected,
    this.state,
    this.value,
  });

  @override
  State<PlacePicker> createState() => _PlacePickerState();
}

class _PlacePickerState extends State<PlacePicker> {
  Timer? _debounce;
  Completer<Iterable<Place>>? _pending;

  Future<Iterable<Place>> _search(String q) {
    // Resolve a superseded lookup right away so the field never waits on it.
    if (_pending?.isCompleted == false) _pending!.complete(const []);
    final completer = _pending = Completer<Iterable<Place>>();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 180), () async {
      try {
        completer.complete(await client.place.search(q, state: widget.state));
      } catch (_) {
        completer.complete(const []);
      }
    });
    return completer.future;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Place>(
      key: ValueKey('${widget.state}-${widget.value?.id}'),
      initialValue: TextEditingValue(text: widget.value?.name ?? ''),
      displayStringForOption: (p) => p.name,
      optionsBuilder: (v) => _search(v.text),
      onSelected: widget.onSelected,
      fieldViewBuilder: (context, controller, focus, onSubmit) => TextField(
        controller: controller,
        focusNode: focus,
        onTap: () {
          // Show suggestions straight away, even before typing.
          if (controller.text.isEmpty) controller.text = '';
        },
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: const Icon(Icons.place_outlined, size: 20),
          suffixIcon: widget.value != null
              ? Icon(
                  Icons.check_circle,
                  color: context.colors.accepted,
                  size: 20,
                )
              : null,
        ),
      ),
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          color: context.colors.paper,
          elevation: 8,
          borderRadius: BorderRadius.circular(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280, maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 6),
              shrinkWrap: true,
              children: [
                for (final p in options)
                  ListTile(
                    dense: true,
                    title: Text(p.name, style: context.text.titleMedium),
                    subtitle: Text(p.state, style: context.text.bodySmall),
                    onTap: () => onSelected(p),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
