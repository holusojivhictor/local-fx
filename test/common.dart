import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:local_fx/src/features/common/domain/enums/app_language_type.dart';
import 'package:local_fx/src/features/common/domain/models/country/country.dart';
import 'package:local_fx/src/features/common/infrastructure/locale_service.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void manuallyInitLocale(LocaleService service, AppLanguageType language) {
  final locale = service.getFormattedLocale(language);
  initializeDateFormatting(locale);
}

LocaleService getLocaleService(AppLanguageType language) {
  final preferenceService = MockPreferenceService();
  when(preferenceService.language).thenReturn(language);
  final service = LocaleService(preferenceService);
  manuallyInitLocale(service, language);
  return service;
}

Position get mockPosition {
  return Position(
    latitude: 52.56141468257813,
    longitude: 5.63943351534394,
    timestamp: DateTime.fromMillisecondsSinceEpoch(
      500,
      isUtc: true,
    ),
    headingAccuracy: 0,
    altitudeAccuracy: 0,
    altitude: 3000,
    accuracy: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}

const mockPlacemark = Placemark(
  administrativeArea: 'Overijssel',
  country: 'Netherlands',
  isoCountryCode: 'NL',
  locality: 'Enschede',
  name: 'Gronausestraat',
  postalCode: '',
  street: 'Gronausestraat 710',
  subAdministrativeArea: 'Enschede',
  subLocality: 'Enschmarke',
  subThoroughfare: '',
  thoroughfare: 'Gronausestraat',
);

const mockCountry = Country(
  name: 'Netherlands',
  isoCode: 'NL',
  iso3Code: 'NLD',
  currencyCode: 'EUR',
  currencyName: 'Euro',
  nameTranslations: {
    'sk': 'Holandsko',
    'se': 'Vuolleeatnamat',
    'pl': 'Holandia',
    'no': 'Nederland',
    'ja': 'オランダ',
    'it': 'Paesi Bassi',
    'zh': '荷兰',
    'nl': 'Nederland',
    'de': 'Niederlande',
    'fr': 'Pays-Bas',
    'es': 'Países Bajos',
    'en': 'Netherlands',
    'pt_BR': 'Países Baixos',
    'sr-Cyrl': 'Холандија',
    'sr-Latn': 'Holandija',
    'zh_TW': '荷蘭',
    'tr': 'Hollanda',
    'ro': 'Olanda',
    'ar': 'هولندا',
    'fa': 'هلند',
    'yue': '荷蘭',
  },
  flag: '🇳🇱',
);

const ffLatestRatesPayload = {
  'base': 'USD',
  'results': {
    'AED': 3.67242,
    'AFN': 66.40422,
    'ANG': 1.78275,
  },
  'updated': '2024-10-27 18:02:29',
  'ms': 4,
};

const ffHistoricalRatesPayload = {
  'date': '2024-10-27',
  'base': 'USD',
  'results': {
    'AED': 3.67219,
    'AFN': 66.53324,
    'ANG': 1.78597,
  },
  'ms': 3,
};

const cbLatestRatesPayload = {
  'meta': {
    'code': 200,
    'disclaimer': 'Usage subject to terms: https://currencybeacon.com/terms',
  },
  'response': {
    'date': '2024-10-28T10:13:49Z',
    'base': 'USD',
    'rates': {
      'LVL': 0.64995182,
      'LYD': 4.82665428,
      'MAD': 9.87263813,
    },
  },
  'date': '2024-10-28T10:13:49Z',
  'base': 'USD',
  'rates': {
    'LVL': 0.64995182,
    'LYD': 4.82665428,
    'MAD': 9.87263813,
  },
};

const cbHistoricalRatesPayload = {
  'meta': {
    'code': 200,
    'disclaimer': 'Usage subject to terms: https://currencybeacon.com/terms',
  },
  'response': {
    'date': '2024-10-27',
    'base': 'USD',
    'rates': {
      'LVL': 0.65166404,
      'LYD': 4.82639389,
      'MAD': 9.89286609,
    },
  },
  'date': '2024-10-27',
  'base': 'USD',
  'rates': {
    'LVL': 0.65166404,
    'LYD': 4.82639389,
    'MAD': 9.89286609,
  },
};
