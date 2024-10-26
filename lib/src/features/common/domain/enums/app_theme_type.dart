enum AppThemeType {
  light,
  dark;

  bool get darkMode {
    return switch (this) {
      AppThemeType.light => false,
      AppThemeType.dark => true,
    };
  }

  static AppThemeType translate({required bool value}) {
    return switch (value) {
      false => AppThemeType.light,
      true => AppThemeType.dark,
    };
  }
}
