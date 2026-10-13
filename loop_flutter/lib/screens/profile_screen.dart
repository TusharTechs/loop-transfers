import 'package:flutter/material.dart';

import '../client.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// First-run profile. Contact details are revealed only to partners in a loop
/// that everyone has accepted.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final member = await client.member.saveProfile(
        _name.text,
        phone: _phone.text,
        email: _email.text,
      );
      AppState.instance.setMember(member);
    } catch (e) {
      setState(() => _error = describeError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PageBody(
        maxWidth: 560,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            const Eyebrow('Step 1 of 2'),
            const SizedBox(height: 10),
            Text('Who are you?', style: context.text.displaySmall),
            const SizedBox(height: 10),
            Text(
              'Your name and contact are kept private. They are shown only to the '
              'people in a loop after every one of them has said yes — so you '
              'can file the joint application together.',
              style: context.text.bodyLarge!.copyWith(height: 1.5),
            ),
            const SizedBox(height: 28),
            TextField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone (for loop partners)'),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email (optional if phone given)'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 14),
              Text(_error!, style: context.text.bodyMedium!.copyWith(color: context.colors.declined)),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(_saving ? 'Saving…' : 'Continue'),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
