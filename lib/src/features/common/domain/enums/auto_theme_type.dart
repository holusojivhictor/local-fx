enum AutoThemeModeType {
  on,
  off;

  bool get system {
    return switch (this) {
      AutoThemeModeType.on => true,
      AutoThemeModeType.off => false,
    };
  }

  static AutoThemeModeType translate({required bool value}) {
    return switch (value) {
      false => AutoThemeModeType.off,
      true => AutoThemeModeType.on,
    };
  }
}
