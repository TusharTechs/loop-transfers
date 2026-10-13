import 'package:flutter/material.dart';

import 'client.dart';
import 'screens/about_screen.dart';
import 'screens/home_tab.dart';
import 'screens/market_screen.dart';
import 'state/app_state.dart';
import 'theme.dart';
import 'widgets/common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  AppState.instance.start();
  runApp(const LoopApp());
}

class LoopApp extends StatelessWidget {
  const LoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loop — close the loop on mutual transfers',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const Shell(),
    );
  }
}

/// Top-level navigation. Rail on wide screens, bottom bar on phones.
class Shell extends StatefulWidget {
  const Shell({super.key});

  static void goTo(BuildContext context, int tab) =>
      context.findAncestorStateOfType<_ShellState>()?.select(tab);

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _tab = 0;

  void select(int tab) => setState(() => _tab = tab);

  static const _destinations = [
    (Icons.all_inclusive, 'My loop'),
    (Icons.public, 'Live market'),
    (Icons.auto_stories_outlined, 'How it works'),
  ];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final body = IndexedStack(
      index: _tab,
      children: const [HomeTab(), MarketScreen(), AboutScreen()],
    );

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _tab,
              onDestinationSelected: select,
              labelType: NavigationRailLabelType.all,
              leading: const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 28),
                child: LoopMark(size: 34),
              ),
              trailing: const Expanded(child: _AccountButton(rail: true)),
              destinations: [
                for (final (icon, label) in _destinations)
                  NavigationRailDestination(icon: Icon(icon), label: Text(label)),
              ],
            ),
            VerticalDivider(width: 1, color: context.colors.line),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const Wordmark(size: 24),
        actions: const [_AccountButton(), SizedBox(width: 8)],
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: select,
        destinations: [
          for (final (icon, label) in _destinations)
            NavigationDestination(icon: Icon(icon), label: label),
        ],
      ),
    );
  }
}

class _AccountButton extends StatelessWidget {
  final bool rail;
  const _AccountButton({this.rail = false});

  @override
  Widget build(BuildContext context) {
    final state = AppState.instance;
    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        if (!state.signedIn) return const SizedBox.shrink();
        final name = state.member?.displayName ?? '';
        final button = PopupMenuButton<String>(
          tooltip: 'Account',
          onSelected: (v) {
            if (v == 'out') state.signOut();
          },
          itemBuilder: (_) => [
            if (name.isNotEmpty)
              PopupMenuItem(enabled: false, child: Text(name)),
            const PopupMenuItem(value: 'out', child: Text('Sign out')),
          ],
          child: CircleAvatar(
            radius: 17,
            backgroundColor: context.colors.ink,
            child: Text(
              name.isEmpty ? '·' : name.characters.first.toUpperCase(),
              style: context.text.labelLarge!.copyWith(color: context.colors.paper),
            ),
          ),
        );
        if (!rail) return Center(child: button);
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 20), child: button),
        );
      },
    );
  }
}
