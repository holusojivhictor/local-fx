class Country {
  Country({
    required this.name,
    required this.isoCode,
    required this.iso3Code,
    required this.currencyCode,
    required this.currencyName,
    required this.flag,
    required this.nameTranslations,
  });

  final String name;
  final String isoCode;
  final String iso3Code;
  final String currencyCode;
  final String currencyName;
  final String flag;
  final Map<String, String> nameTranslations;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isoCode': isoCode,
      'iso3Code': iso3Code,
      'currencyCode': currencyCode,
      'currencyName': currencyName,
      'flag': flag,
      'nameTranslations': nameTranslations,
    };
  }

  String localizedName(String languageCode) {
    return nameTranslations[languageCode] ?? name;
  }
}
