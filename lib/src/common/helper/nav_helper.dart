import 'package:go_router/go_router.dart';

class NavHelper {
  static void goToTab(int index, GoRouter router) {
    switch (index) {
      case 0:
        router.go('/dashboard');
        break;
      case 1:
        router.go('/settings');
        break;
      case 2:
        router.go('/notifications');
        break;
      case 3:
        router.go('/profile');
        break;
    }
  }

  static int currentIndex(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/settings')) return 1;
    if (location.startsWith('/notifications')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }
}
