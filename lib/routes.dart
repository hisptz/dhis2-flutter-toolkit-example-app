import 'package:dhis2_flutter_toolkit/modules/home.dart';
import 'package:dhis2_flutter_toolkit/modules/login.dart';
import 'package:dhis2_flutter_toolkit/modules/router.dart';
import 'package:dhis2_flutter_toolkit/modules/sync.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => MainNavigation()),
  GoRoute(path: "/sync", builder: (context, state) => const SyncPage()),
  GoRoute(path: "/home", builder: (context, state) => const Home()),
  GoRoute(path: "/login", builder: (context, state) => const Login()),
]);
