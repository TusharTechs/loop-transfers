import 'package:flutter/material.dart';

import '../state/app_state.dart';
import '../widgets/common.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'request_screen.dart';
import 'welcome_screen.dart';

/// Routes the "My loop" tab by account state: welcome → profile → first
/// request → dashboard.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final Widget child;
        if (!state.signedIn) {
          child = const WelcomeScreen();
        } else if (!state.loaded) {
          child = const Loading(label: 'Loading your requests…');
        } else if (state.member == null) {
          child = const ProfileScreen();
        } else if (state.listings.isEmpty) {
          child = const RequestScreen();
        } else {
          child = const DashboardScreen();
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: KeyedSubtree(key: ValueKey(child.runtimeType), child: child),
        );
      },
    );
  }
}
