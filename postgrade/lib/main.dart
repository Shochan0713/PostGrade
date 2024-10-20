import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:postgrade/styles/custom_theme.dart';
import 'package:shell/shell.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/router/app_router.dart';

// void startNodeJsServer() async {
//   try {
//     // pm2でNode.jsサーバーを起動するコマンド
//     ProcessResult result = await Process.run(
//       'C:\\Users\\user\\AppData\\Roaming\\npm\\pm2.cmd',
//       ['start', 'server.js', '--name', 'postgrade-server'],
//       runInShell: true,
//       workingDirectory:
//           'C:\\Users\\user\\Desktop\\Work\\PostGrade\\PostGrade\\PostGrade-backend\\server.js', // Node.jsのアプリが存在するディレクトリ
//     );

//     if (result.exitCode == 0) {
//       print('Server started successfully: ${result.stdout}');
//     } else {
//       print('Failed to start server: ${result.stderr}');
//     }
//   } catch (e) {
//     print('Error starting Node.js server: $e');
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebaseの初期化
  final goRouter = AppRouter().router;
  // startNodeJsServer();
  runApp(ProviderScope(child: PostGrade(router: goRouter)));
}

class PostGrade extends StatelessWidget {
  final GoRouter router;

  const PostGrade({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    print("Main処理");
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
