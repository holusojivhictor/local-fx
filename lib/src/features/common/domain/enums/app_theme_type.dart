enum AppThemeType {
  light,
  dark;

  bool get darkMode {
    switch (this) {
      case AppThemeType.light:
        return false;
      case AppThemeType.dark:
        return true;
    }
  }

  static AppThemeType translate({required bool value}) {
    return switch (value) {
      false => AppThemeType.light,
      true => AppThemeType.dark,
    };
  }
}
