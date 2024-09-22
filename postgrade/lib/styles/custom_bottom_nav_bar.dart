import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/services/providers.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  static const List<String> _routes = [
    '/', // ホーム画面
    '/search', // 検索画面
    '/notifications', // 通知画面
    '/profile', // プロフィール画面
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '検索',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '通知',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'プロフィール',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[300],
      backgroundColor: Colors.grey,
      onTap: (index) {
        ref.read(selectedIndexProvider.notifier).state = index;
        context.go(_routes[index]);
      },
    );
  }
}
