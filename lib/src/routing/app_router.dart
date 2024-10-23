import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_fx/src/features/home/presentation/home_page.dart';
import 'package:local_fx/src/features/settings/presentation/settings_page.dart';
import 'package:local_fx/src/routing/mobile_scaffold.dart';

enum AppRoute {
  home('/'),
  settings('/settings');

  const AppRoute(this.path);

  final String path;
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');

  static final _settingsKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

  static final GoRouter _router = GoRouter(
    initialLocation: AppRoute.home.path,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return MobileScaffold(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _homeKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.settings.path,
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const SettingsPage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
