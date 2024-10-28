import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:local_fx/src/extensions/date_time_extensions.dart';
import 'package:local_fx/src/features/common/domain/models/country/country.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

import '../common.dart';
import '../helpers.dart';
import '../mocks.mocks.dart';

void main() {
  const geolocatorChannel = MethodChannel('flutter.baseflow.com/geolocator');
  const fastForexHost = 'api.fastforex.io';
  const currencyBeaconHost = 'api.currencybeacon.com';
  const ffAccessKey = <String, String>{'api_key': 'FAST_FOREX_API_KEY'};
  const cbAccessKey = <String, String>{'api_key': 'CB_API_KEY'};
  const currencyCode = 'NGN';
  final date = yesterday;

  final dio = Dio();
  late DioAdapter dioAdapter;
  late NetworkClient networkClient;
  late FastForexService fastForexService;
  late CurrencyBeaconService currencyBeaconService;
  late LocalFXService localFXService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const CustomRequestMatcher(matchMethod: true),
    );

    final logger = MockLoggingService();
    networkClient = NetworkClient(logger, dio: dio);
    fastForexService = FastForexService(networkClient);
    currencyBeaconService = CurrencyBeaconService(networkClient);
    localFXService = LocalFXService(fastForexService, currencyBeaconService);
  });

  Future<dynamic> geolocatorHandler(MethodCall methodCall) async {
    if (methodCall.method == 'getCurrentPosition') {
      return mockPosition.toJson();
    }
  }

  group('Get country from location', () {
    setUpAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(geolocatorChannel, geolocatorHandler);
      GeocodingPlatform.instance = MockGeocodingPlatform();
    });

    test('and return position', () async {
      final position = await localFXService.getPosition();
      expect(position, mockPosition);
    });

    test('and return iso country code', () async {
      final code = await localFXService.getIsoCountryCodeFromPosition();
      expect(code, mockPlacemark.isoCountryCode);
    });

    test('and return country', () async {
      final country =
          localFXService.getCountryFromIsoCode(mockPlacemark.isoCountryCode!);
      expect(country, mockCountry);
    });
  });

  group('Get pairs from currency code', () {
    test('and return pairs with first provider', () async {
      final ffLatestUri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/fetch-all',
        queryParameters: {'from': currencyCode}..addAll(ffAccessKey),
      );

      final ffHistoricalUri = ffLatestUri.replace(
        path: '/historical',
        queryParameters: Map.from(ffLatestUri.queryParameters)
          ..addAll({'date': date}),
      );

      dioAdapter
        ..onGet(
          ffLatestUri.toString(),
          (request) => request.reply(200, ffLatestRatesPayload),
        )
        ..onGet(
          ffHistoricalUri.toString(),
          (request) => request.reply(200, ffHistoricalRatesPayload),
        );

      final pairs = await localFXService.getPairsFromCurrencyCode(
        currencyCode,
      );
      expect(pairs, isNotEmpty);
    });

    test('and return pairs with second provider', () async {
      final ffLatestUri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/fetch-all',
        queryParameters: {'from': currencyCode},
      );
      final options = RequestOptions(
        path: ffLatestUri.path,
        method: 'GET',
        queryParameters: ffLatestUri.queryParameters,
      );

      final cbLatestUri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/latest',
        queryParameters: {'base': currencyCode}..addAll(cbAccessKey),
      );

      final cbHistoricalUri = cbLatestUri.replace(
        path: 'v1/historical',
        queryParameters: Map.from(cbLatestUri.queryParameters)
          ..addAll({'date': date}),
      );

      dioAdapter
        ..onGet(
          ffLatestUri.toString(),
          (request) => request.throws(
            403,
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: options,
            ),
          ),
        )
        ..onGet(
          cbLatestUri.toString(),
          (request) => request.reply(200, cbLatestRatesPayload),
        )
        ..onGet(
          cbHistoricalUri.toString(),
          (request) => request.reply(200, cbHistoricalRatesPayload),
        );

      final pairs = await localFXService.getPairsFromCurrencyCode(
        currencyCode,
      );
      expect(pairs, isNotEmpty);
    });

    test('and throw exception if currency is not fallback', () async {
      final ffLatestUri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/fetch-all',
        queryParameters: {'from': currencyCode},
      );
      final ffOptions = RequestOptions(
        path: ffLatestUri.path,
        method: 'GET',
        queryParameters: ffLatestUri.queryParameters,
      );

      final cbLatestUri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/latest',
        queryParameters: {'base': currencyCode},
      );
      final cbOptions = RequestOptions(
        path: cbLatestUri.path,
        method: 'GET',
        queryParameters: cbLatestUri.queryParameters,
      );

      dioAdapter
        ..onGet(
          ffLatestUri.toString(),
          (request) => request.throws(
            403,
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: ffOptions,
            ),
          ),
        )
        ..onGet(
          cbLatestUri.toString(),
          (request) => request.throws(
            403,
            DioException(
              type: DioExceptionType.badResponse,
              requestOptions: cbOptions,
            ),
          ),
        );

      final pairs = localFXService.getPairsFromCurrencyCode(currencyCode);
      await expectLater(pairs, throwsA(isA<AppException>()));
    });
  });
}

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
