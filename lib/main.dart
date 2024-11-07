import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifelite/screen/CalcularPeso.dart';

void main() {
  runApp(Lifelite());
}

class Lifelite extends StatelessWidget {
  final GoRouter _goRoute = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, value) => const CalcularPeso(),
      ),
    ],
  );

  Lifelite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _goRoute.routerDelegate,
      routeInformationParser: _goRoute.routeInformationParser,
      routeInformationProvider: _goRoute.routeInformationProvider,
    );
  }
}
