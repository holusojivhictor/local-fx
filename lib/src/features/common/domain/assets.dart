class Assets {
  const Assets._();

  static String svgsBasePath = 'assets/svgs';

  static String getSvgPath(String name) => '$svgsBasePath/$name';
}
