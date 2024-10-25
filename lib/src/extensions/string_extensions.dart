extension StringExtensions on String {
  /// A simple placeholder that can be used to search all the hardcoded strings
  /// in the code (useful to identify strings that need to be localized).
  String get hardcoded => this;

  String get noDiacritics {
    var s = this;
    const withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (var i = 0; i < withDia.length; i++) {
      s = s.replaceAll(withDia[i], withoutDia[i]);
    }

    return s;
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty =>
      this == null || this!.isEmpty || this!.trim().isEmpty;
  bool get isNotNullNorEmpty => !isNullOrEmpty;

  bool get isNullOrEmptyOrHasNull =>
      this == null || this!.isEmpty || this!.contains('null');
  bool get isNotNullNorEmptyNorHasNull => !isNullOrEmptyOrHasNull;
}
