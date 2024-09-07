import 'package:go_router/go_router.dart';
import 'package:postgrade/views/home_view.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => HomePage(),
          ),
        ]);
}
