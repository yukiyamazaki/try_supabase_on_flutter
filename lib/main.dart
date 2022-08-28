import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:try_supabase_on_flutter/sign_up.dart';

import 'database_widget.dart';
import 'home.dart';
import 'sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'],
    anonKey: dotenv.env['SUPABASE_ANON_KEY'],
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'GoRouter Example',
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: RoutePath.home,
  routes: <GoRoute>[
    GoRoute(
      path: RoutePath.home,
      builder: (BuildContext context, GoRouterState state) {
        return const Home();
      },
    ),
    GoRoute(
      path: RoutePath.database,
      builder: (BuildContext context, GoRouterState state) {
        return const DatabaseWidget();
      },
    ),
    GoRoute(
      path: RoutePath.signUp,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpWidget();
      },
    ),
    GoRoute(
      path: RoutePath.signIn,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInWidget();
      },
    ),
  ],
);

class RoutePath {
  static const home = '/';
  static const database = '/database';
  static const signUp = '/sign_up';
  static const signIn = '/sign_in';
}
