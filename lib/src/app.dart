import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/config/injection.dart';
import 'package:local_fx/src/features/app_widget.dart';
import 'package:local_fx/src/features/common/application/bloc.dart';
import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';
import 'package:local_fx/src/features/home/application/home_cubit.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

class LocalFXApp extends StatelessWidget {
  const LocalFXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final preferenceService = getIt<PreferenceService>();
            final localeService = getIt<LocaleService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return AppBloc(
              loggingService,
              preferenceService,
              localeService,
              deviceInfoService,
            )..add(AppInitialize());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final localFXService = getIt<LocalFXService>();
            return HomeCubit(localFXService)..init();
          },
        ),
        BlocProvider(
          create: (ctx) {
            final preferenceService = getIt<PreferenceService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return PreferenceBloc(
              preferenceService,
              deviceInfoService,
              ctx.read<AppBloc>(),
            )..add(PreferenceInitialize());
          },
        ),
      ],
      child: const AppWidget(),
    );
  }
}
