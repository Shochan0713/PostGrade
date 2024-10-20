import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/views/base_view.dart';
import 'package:postgrade/views/login_view.dart';
import 'package:postgrade/views/notifications_view.dart';
import 'package:postgrade/views/post_detail_view.dart';
import 'package:postgrade/views/search_view.dart';
import 'package:postgrade/views/setting_view.dart';
import 'package:postgrade/views/signup_view.dart';
import 'package:postgrade/views/user_profile_view.dart'; // 新規投稿ページ

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          initialLocation: '/',
          redirect: (BuildContext context, GoRouterState state) {
            final user = FirebaseAuth.instance.currentUser;
            final isLoggingIn = state.uri.toString() == '/login';
            final isSigningUp = state.uri.toString() == '/signup';

            // ユーザーがログインしていない場合、ログインまたはサインアップページへリダイレクト
            if (user == null && !isLoggingIn && !isSigningUp) {
              return '/login';
            }

            // ログイン済みでログインページにいる場合はホームにリダイレクト
            if (user != null && (isLoggingIn || isSigningUp)) {
              return '/';
            }

            return null; // 他の場所にはリダイレクトしない
          },
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BasePage(), // ログイン後の画面
            ),
            GoRoute(
              path: '/postdetail',
              builder: (context, state) {
                final post = state.extra as Post?;
                if (post == null) {
                  return const Scaffold(
                    body: Center(child: Text('Post not found')),
                  );
                }
                return PostDetailPage(post: post);
              },
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) => LoginPage(), // ログインページ
            ),
            GoRoute(
              path: '/signup',
              builder: (context, state) => SignUpPage(), // サインアップページ
            ),
            GoRoute(
              path: '/setting',
              builder: (context, state) {
                final userId =
                    FirebaseAuth.instance.currentUser?.uid; // 現在のユーザーIDを取得
                if (userId == null) {
                  return const Scaffold(
                    body: Center(child: Text('ログインしていないため設定ページにアクセスできません')),
                  );
                }
                return SettingPage(userId: userId); // userIdをSettingPageに渡す
              },
            ),
            GoRoute(
              path: '/search',
              builder: (context, state) => SearchPage(), // 検索ページ
            ),
            GoRoute(
              path: '/notifications',
              builder: (context, state) => NotificationPage(), // 通知ページ
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) {
                // final User? user = FirebaseAuth.instance.currentUser;
                // final String userId =
                //     user?.uid ?? ''; // FirebaseAuthからuserIdを取得
                return ProfilePage(); // userIdをProfilePageに渡す
              },
            ),
          ],
        );
}
