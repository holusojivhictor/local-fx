import 'package:equatable/equatable.dart';
import 'package:local_fx/src/features/common/domain/enums/enums.dart';

class Preferences extends Equatable {
  const Preferences({
    required this.appTheme,
    required this.appLanguage,
    required this.isFirstInstall,
    required this.themeMode,
  });

  final AppThemeType appTheme;
  final AppLanguageType appLanguage;
  final bool isFirstInstall;
  final AutoThemeModeType themeMode;

  Preferences copyWith({
    AppThemeType? appTheme,
    AppLanguageType? appLanguage,
    bool? isFirstInstall,
    AutoThemeModeType? themeMode,
  }) {
    return Preferences(
      appTheme: appTheme ?? this.appTheme,
      appLanguage: appLanguage ?? this.appLanguage,
      isFirstInstall: isFirstInstall ?? this.isFirstInstall,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [
    appTheme,
    appLanguage,
    isFirstInstall,
    themeMode,
  ];
}
