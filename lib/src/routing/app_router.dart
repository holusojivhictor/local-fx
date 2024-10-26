import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_fx/src/config/injection.dart';
import 'package:local_fx/src/features/home/presentation/home_page.dart';
import 'package:local_fx/src/features/pair_info/application/pair_info_cubit.dart';
import 'package:local_fx/src/features/pair_info/domain/models/args/pair_info_page_args.dart';
import 'package:local_fx/src/features/pair_info/infrastructure/twelve_data_service.dart';
import 'package:local_fx/src/features/pair_info/presentation/pair_info_page.dart';
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
                routes: <RouteBase>[
                  GoRoute(
                    path: 'pair-info',
                    name: 'pair-info',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final args = state.extra! as PairInfoPageArgs;

                      return BlocProvider<PairInfoCubit>(
                        create: (ctx) {
                          final twelveDataService = getIt<TwelveDataService>();
                          return PairInfoCubit(
                            twelveDataService,
                            base: args.base,
                            symbol: args.symbol,
                          )..init();
                        },
                        child: const PairInfoPage(),
                      );
                    },
                  ),
                ],
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
