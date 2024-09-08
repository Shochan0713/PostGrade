import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:postgrade/styles/custom_theme.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebaseの初期化
  final goRouter = AppRouter().router;
  runApp(ProviderScope(child: PostGrade(router: goRouter)));
}

class PostGrade extends StatelessWidget {
  final GoRouter router;

  const PostGrade({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PostGrade',
      theme: CustomTheme.lightTheme, // カスタムテーマを設定
      darkTheme: CustomTheme.darkTheme, // ダークテーマを設定
      themeMode: ThemeMode.light, // または ThemeMode.dark, ThemeMode.system
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
