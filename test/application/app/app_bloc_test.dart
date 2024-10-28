import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/enums/enums.dart';
import 'package:local_fx/src/features/common/domain/models/models.dart';
import 'package:local_fx/src/features/common/infrastructure/locale_service.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.mocks.dart';

void main() {
  const defaultAppName = 'Local FX';
  const defaultLang = AppLanguageType.english;
  const defaultThemeMode = AutoThemeModeType.off;
  const defaultTheme = AppThemeType.light;
  const defaultLanguage = Language('en', 'US');
  const defaultAppPreferences = Preferences(
    appTheme: defaultTheme,
    appLanguage: defaultLang,
    isFirstInstall: true,
    themeMode: defaultThemeMode,
  );

  AppBloc getBloc({
    String appName = defaultAppName,
    Preferences? appPreferences,
    bool versionChanged = false,
  }) {
    final preferences = appPreferences ?? defaultAppPreferences;
    final logger = MockLoggingService();

    final preferenceService = MockPreferenceService();
    when(preferenceService.language).thenReturn(preferences.appLanguage);
    when(preferenceService.autoThemeMode).thenReturn(preferences.themeMode);
    when(preferenceService.appTheme).thenReturn(preferences.appTheme);
    when(preferenceService.isFirstInstall)
        .thenReturn(preferences.isFirstInstall);
    when(preferenceService.preferences).thenReturn(preferences);

    final localeService = LocaleService(preferenceService);
    final deviceInfoService = MockDeviceInfoService();
    when(deviceInfoService.appName).thenReturn(appName);
    when(deviceInfoService.versionChanged).thenReturn(versionChanged);

    return AppBloc(
      logger,
      preferenceService,
      localeService,
      deviceInfoService,
    );
  }

  test('Initial state', () {
    expect(getBloc().state, const AppState.init());
  });

  blocTest<AppBloc, AppState>(
    'emits init state',
    build: getBloc,
    act: (bloc) => bloc.add(AppInitialize()),
    expect: () => <AppState>[
      AppState(
        appTitle: defaultAppName,
        theme: defaultTheme,
        autoThemeMode: defaultThemeMode,
        initialized: true,
        language: defaultLanguage,
        firstInstall: defaultAppPreferences.isFirstInstall,
        versionChanged: false,
      ),
    ],
  );

  group('Theme changed', () {
    blocTest<AppBloc, AppState>(
      'updates the theme mode in the state',
      build: getBloc,
      act: (bloc) => bloc
        ..add(AppInitialize())
        ..add(AppThemeModeChanged(newValue: AutoThemeModeType.on)),
      skip: 1,
      expect: () => <AppState>[
        AppState(
          appTitle: defaultAppName,
          theme: defaultAppPreferences.appTheme,
          autoThemeMode: AutoThemeModeType.on,
          initialized: true,
          language: defaultLanguage,
          firstInstall: defaultAppPreferences.isFirstInstall,
          versionChanged: false,
        ),
      ],
    );

    blocTest<AppBloc, AppState>(
      'updates the theme in the state',
      build: getBloc,
      act: (bloc) => bloc
        ..add(AppInitialize())
        ..add(AppThemeChanged(newValue: AppThemeType.dark)),
      skip: 1,
      expect: () => <AppState>[
        AppState(
          appTitle: defaultAppName,
          theme: AppThemeType.dark,
          autoThemeMode: defaultThemeMode,
          initialized: true,
          language: defaultLanguage,
          firstInstall: defaultAppPreferences.isFirstInstall,
          versionChanged: false,
        ),
      ],
    );

    group('Language changed', () {
      blocTest<AppBloc, AppState>(
        'updates the language in the state',
        build: () => getBloc(
          appPreferences: defaultAppPreferences.copyWith
              .call(appLanguage: AppLanguageType.spanish),
        ),
        act: (bloc) => bloc
          ..add(AppInitialize())
          ..add(AppLanguageChanged(newValue: AppLanguageType.spanish)),
        expect: () => [
          AppState(
            appTitle: defaultAppName,
            theme: defaultAppPreferences.appTheme,
            language: languagesMap.entries
                .firstWhere((kvp) => kvp.key == AppLanguageType.spanish)
                .value,
            initialized: true,
            autoThemeMode: defaultThemeMode,
            firstInstall: defaultAppPreferences.isFirstInstall,
            versionChanged: false,
          ),
        ],
      );
    });
  });
}
