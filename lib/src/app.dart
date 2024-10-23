import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/config/injection.dart';
import 'package:local_fx/src/features/app_widget.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';

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
      ],
      child: const AppWidget(),
    );
  }
}
