import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int selectedIndex = 0;

    if (location.startsWith('/')) selectedIndex = 0;
    if (location.startsWith('/events')) selectedIndex = 1;
    if (location.startsWith('/announcement')) selectedIndex = 2;
    if (location.startsWith('/fines')) selectedIndex = 3;
    if (location.startsWith('/profile')) selectedIndex = 4;

    final colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.secondary.withValues(alpha: 0.6),
      backgroundColor: colorScheme.surface,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/events');
            break;
          case 2:
            context.go("/announcements");
            break;
          case 3:
            context.go("/fines");
            break;
          case 4:
            context.go("/profile");
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          label: 'Annoucements',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Fines',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
