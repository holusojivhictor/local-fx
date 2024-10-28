import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/application/preference/preference_bloc.dart';
import 'package:local_fx/src/features/common/domain/enums/enums.dart';
import 'package:local_fx/src/features/common/domain/models/models.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.mocks.dart';

class _FakeAppBloc extends Fake implements AppBloc {
  @override
  void add(AppEvent event) {}
}

void main() {
  const appVersion = '1.0.0';
  const defaultPreferences = Preferences(
    appTheme: AppThemeType.light,
    appLanguage: AppLanguageType.english,
    isFirstInstall: true,
    themeMode: AutoThemeModeType.off,
  );

  PreferenceBloc getBloc({Preferences? appPreferences}) {
    final preferences = appPreferences ?? defaultPreferences;
    final preferenceService = MockPreferenceService();
    when(preferenceService.preferences).thenReturn(preferences);
    when(preferenceService.autoThemeMode).thenReturn(preferences.themeMode);
    when(preferenceService.appTheme).thenReturn(preferences.appTheme);
    when(preferenceService.language).thenReturn(preferences.appLanguage);
    when(preferenceService.isFirstInstall)
        .thenReturn(preferences.isFirstInstall);

    final deviceInfoService = MockDeviceInfoService();
    when(deviceInfoService.version).thenReturn(appVersion);
    when(deviceInfoService.appName).thenReturn('Local FX');

    final appBloc = _FakeAppBloc();

    return PreferenceBloc(
      preferenceService,
      deviceInfoService,
      appBloc,
    );
  }

  test('Initial state', () {
    expect(getBloc().state, const PreferenceState.init());
  });

  blocTest<PreferenceBloc, PreferenceState>(
    'Init',
    build: getBloc,
    act: (bloc) => bloc.add(PreferenceInitialize()),
    expect: () => <PreferenceState>[
      PreferenceState(
        currentTheme: defaultPreferences.appTheme,
        currentLanguage: defaultPreferences.appLanguage,
        appVersion: appVersion,
        themeMode: defaultPreferences.themeMode,
      ),
    ],
  );

  blocTest<PreferenceBloc, PreferenceState>(
    'Preferences changed',
    build: getBloc,
    act: (bloc) => bloc
      ..add(PreferenceInitialize())
      ..add(PreferenceThemeChanged(newValue: AppThemeType.dark))
      ..add(PreferenceLanguageChanged(newValue: AppLanguageType.spanish))
      ..add(PreferenceAutoThemeModeChanged(newValue: AutoThemeModeType.on)),
    skip: 3,
    expect: () => <PreferenceState>[
      const PreferenceState(
        currentTheme: AppThemeType.dark,
        currentLanguage: AppLanguageType.spanish,
        themeMode: AutoThemeModeType.on,
        appVersion: appVersion,
      ),
    ],
  );
}
