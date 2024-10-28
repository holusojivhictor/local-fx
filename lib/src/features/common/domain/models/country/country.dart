import 'package:equatable/equatable.dart';

class Country extends Equatable {
  const Country({
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

  String localizedName(String languageCode) {
    return nameTranslations[languageCode] ?? name;
  }

  @override
  List<Object?> get props => <Object?>[
    name,
    isoCode,
    iso3Code,
    currencyCode,
    currencyName,
    flag,
    nameTranslations,
  ];
}
