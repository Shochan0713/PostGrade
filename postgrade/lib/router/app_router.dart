import 'package:go_router/go_router.dart';
import 'package:postgrade/views/home_view.dart';
import 'package:postgrade/views/login_view.dart';
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
            // pageBuilder: (context, state) => MaterialPage(
            //       key: state.pageKey,
            //       child: HomePage(),
            //     )),
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
          ],
        );
}
