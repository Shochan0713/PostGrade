import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/router/app_router.dart';
import 'services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebaseの初期化
  final appRouter = AppRouter();
  runApp(ProviderScope(child: PostGrade(router: appRouter.router)));
}

class PostGrade extends StatelessWidget {
  final GoRouter router;

  PostGrade({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PostGrade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}
