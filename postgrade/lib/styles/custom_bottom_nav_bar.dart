import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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

    return CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.search, size: 30),
        Icon(Icons.add, size: 30), // 追加ボタン
        Icon(Icons.notifications, size: 30),
        Icon(Icons.account_circle, size: 30),
      ],
      onTap: (index) {
        if (index == 2) {
          // Handle the add button action here
          print('Add button pressed');
          return; // Do nothing for the add button
        }
        ref.read(selectedIndexProvider.notifier).state = index;
        context.go(_routes[
            index > 2 ? index - 1 : index]); // Adjust for the add button
      },
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.blue,
      color: Colors.grey,
      height: 60,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
    );
  }
}
