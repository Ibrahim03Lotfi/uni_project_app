import 'package:flutter/material.dart';
import 'package:sports_news_app/data/notifiers.dart';
import 'package:sports_news_app/modules/Navbar/main_nav_bar.dart';
import 'package:sports_news_app/modules/pages/following_page.dart';
import 'package:sports_news_app/modules/pages/leagues_page.dart';
import 'package:sports_news_app/modules/pages/matches_page.dart';
import 'package:sports_news_app/modules/pages/more_page.dart';
import 'package:sports_news_app/modules/pages/news_page.dart';

/// All main app pages
final List<Widget> pages = [
  const MatchesPage(),
  const NewsPage(),
  const LeaguesPage(),
  const FollowingPage(),
  const MorePage(),
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, _) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.92, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: KeyedSubtree(
              key: ValueKey<int>(selectedPage),
              child: pages[selectedPage],
            ),
          );
        },
      ),
      bottomNavigationBar: const NavBarWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ويدجت مساعدة للحفاظ على حالة الصفحات
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({super.key, required this.child});

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
