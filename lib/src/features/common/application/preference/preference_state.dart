part of 'preference_bloc.dart';

class PreferenceState extends Equatable {
  const PreferenceState({
    required this.themeMode,
    required this.currentTheme,
    required this.currentLanguage,
    required this.appVersion,
  });

  const PreferenceState.init()
      : themeMode = AutoThemeModeType.off,
        currentTheme = AppThemeType.dark,
        currentLanguage = AppLanguageType.english,
        appVersion = '1.0';

  final AutoThemeModeType themeMode;
  final AppThemeType currentTheme;
  final AppLanguageType currentLanguage;
  final String appVersion;

  PreferenceState copyWith({
    AutoThemeModeType? themeMode,
    AppThemeType? currentTheme,
    AppLanguageType? currentLanguage,
    String? appVersion,
  }) {
    return PreferenceState(
      themeMode: themeMode ?? this.themeMode,
      currentTheme: currentTheme ?? this.currentTheme,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object?> get props => [
    themeMode,
    currentTheme,
    currentLanguage,
    appVersion,
  ];
}
