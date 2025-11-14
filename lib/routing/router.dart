import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:felicitime/features/dashboard/ui/screens/dashboard.dart';
import 'package:felicitime/features/user/ui/screens/profile.dart';
import 'package:felicitime/routing/routes.dart';
import 'package:felicitime/ui/screens/base.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {

  return GoRouter(
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const BaseScreen(screen: DashboardScreen());
        },
      ),
      GoRoute(
        path: Routes.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const BaseScreen(screen: ProfileScreen());
        },
      ),
    ],
  );
}
