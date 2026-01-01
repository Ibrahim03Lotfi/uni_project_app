import 'package:flutter/material.dart';
import 'package:sports_news_app/data/notifiers.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        final scheme = Theme.of(context).colorScheme;
        return Directionality(
          textDirection: TextDirection.ltr,
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: scheme.surface,
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>((
                states,
              ) {
                final selected = states.contains(MaterialState.selected);
                return TextStyle(
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 12,
                );
              }),
              iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>((
                states,
              ) {
                final selected = states.contains(MaterialState.selected);
                return IconThemeData(
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  size: selected ? 28 : 26,
                );
              }),
            ),
            child: NavigationBar(
              height: 70,
              elevation: 6,
              backgroundColor: scheme.surface,
              selectedIndex: selectedPage,
              onDestinationSelected: (value) {
                selectedPageNotifier.value = value;
              },
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                _buildNavItem(Icons.sports_soccer_sharp, 'Matches', 0),
                _buildNavItem(Icons.newspaper_sharp, 'News', 1),
                _buildNavItem(Icons.emoji_events_outlined, 'Leagues', 2),
                _buildNavItem(Icons.groups_outlined, 'Following', 3),
                _buildNavItem(Icons.list, 'More', 4),
              ],
            ),
          ),
        );
      },
    );
  }

  NavigationDestination _buildNavItem(IconData icon, String label, int index) {
    return NavigationDestination(icon: Icon(icon), label: label);
  }
}
