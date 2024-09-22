import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/views/home_view.dart';
import 'package:postgrade/views/login_view.dart';
import 'package:postgrade/views/notifications_view.dart';
import 'package:postgrade/views/post_detail_view.dart';
import 'package:postgrade/views/search_view.dart';
import 'package:postgrade/views/setting_view.dart';
import 'package:postgrade/views/signup_view.dart'; // 新規投稿ページ

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: '/postdetail',
              builder: (context, state) {
                final post = state.extra as Post?;
                if (post == null) {
                  // ignore: avoid_print
                  print('Scaffold実行');
                  // エラーハンドリング
                  return const Scaffold(
                    body: Center(child: Text('Post not found')),
                  );
                }
                return PostDetailPage(post: post);
              },
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: '/signup',
              builder: (context, state) => const SignUpPage(),
            ),
            GoRoute(
              path: '/setting',
              builder: (context, state) => const SettingPage(),
            ),
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchPage(),
            ),
            GoRoute(
              path: '/notifications',
              builder: (context, state) => NotificationPage(),
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const SettingPage(),
            ),
          ],
        );
}
