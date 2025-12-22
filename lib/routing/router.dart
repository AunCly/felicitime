import 'package:felicitime/features/capsules/ui/screens/capsules.dart';
import 'package:felicitime/features/moments/ui/screens/moments.dart';
import 'package:felicitime/features/moods/ui/screens/moods.dart';
import 'package:felicitime/features/settings/ui/screens/settings.dart';
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
        path: Routes.capsules,
        builder: (BuildContext context, GoRouterState state) {
          return const BaseScreen(screen: CapsulesScreen());
        },
      ),
      GoRoute(
        path: Routes.moods,
        builder: (BuildContext context, GoRouterState state) {
          return const BaseScreen(screen: MoodsScreen());
        },
      ),
      GoRoute(
        path: Routes.moments,
        builder: (BuildContext context, GoRouterState state) {
          return const BaseScreen(screen: MomentsScreen());
        },
      ),
      GoRoute(
        path: Routes.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const BaseScreen(screen: SettingsScreen());
        },
      ),
    ],
  );
}
