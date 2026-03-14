import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_bloc.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_event.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_nav_bloc.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_nav_event.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_nav_state.dart';
import 'package:isoule_ai/features/ai_chat/presentation/screens/ai_chat_screen.dart';
import 'package:isoule_ai/features/home_screen/presentation/screens/home_screen.dart';
import 'package:isoule_ai/features/profile/presentation/screens/profile_screen.dart';
import 'package:isoule_ai/features/timeline/presentation/screens/timeline_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final PageController _pageController;

  static const List<Widget> _tabs = <Widget>[
    HomeScreen(),
    TimelineScreen(),
    AiChatScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => DashboardNavBloc(),
      child: BlocBuilder<DashboardNavBloc, DashboardNavState>(
        builder: (context, navState) {
          return Scaffold(
            backgroundColor: theme.colorScheme.primary,
            body: SafeArea(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<DashboardNavBloc>().add(
                    DashboardTabSelected(index),
                  );
                },
                children: _tabs,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navState.selectedIndex,
              onTap: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                context.read<DashboardNavBloc>().add(
                  DashboardTabSelected(index),
                );
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: theme.scaffoldBackgroundColor,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.onBackground.withOpacity(
                0.6,
              ),
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timeline),
                  activeIcon: Icon(Icons.timeline_rounded),
                  label: 'Timeline',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  activeIcon: Icon(Icons.chat_bubble),
                  label: 'AI Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
