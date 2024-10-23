import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/domain/enums/auto_theme_type.dart';
import 'package:local_fx/src/features/common/presentation/extensions/app_theme_type_extensions.dart';
import 'package:local_fx/src/localization/generated/l10n.dart';
import 'package:local_fx/src/routing/app_router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final delegates = <LocalizationsDelegate<dynamic>>[
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
    return BlocBuilder<AppBloc, AppState>(
      builder: (ctx, s) {
        final auto = s.autoThemeMode == AutoThemeModeType.on;
        final locale = Locale(s.language.code, s.language.countryCode);

        return MaterialApp.router(
          title: s.appTitle,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: auto ? s.theme.lightTheme : s.theme.themeData,
          darkTheme: auto ? s.theme.darkTheme : null,
          locale: locale,
          localizationsDelegates: delegates,
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
