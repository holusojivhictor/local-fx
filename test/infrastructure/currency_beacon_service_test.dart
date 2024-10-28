import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/currency_beacon_service.dart';

import '../common.dart';
import '../helpers.dart';
import '../mocks.mocks.dart';

void main() {
  const currencyBeaconHost = 'api.currencybeacon.com';
  const accessKey = <String, String>{'api_key': 'API_KEY'};
  const base = 'USD';
  const date = '2024-10-27';

  final dio = Dio();
  late DioAdapter dioAdapter;
  late NetworkClient networkClient;
  late CurrencyBeaconService currencyBeaconService;

  setUp(() {
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const CustomRequestMatcher(matchMethod: true),
    );

    final logger = MockLoggingService();
    networkClient = NetworkClient(logger, dio: dio);
    currencyBeaconService = CurrencyBeaconService(networkClient);
  });

  group('Get latest rates', () {
    test('and return exchange rates when base is not null', () async {
      final uri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/latest',
        queryParameters: {'base': base}..addAll(accessKey),
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.reply(200, cbLatestRatesPayload),
      );

      final rates = await currencyBeaconService.getLatestRates(base: base);
      expect(rates, ExchangeRates.fromCurrencyBeacon(cbLatestRatesPayload));
    });

    test('and throw exception', () async {
      final uri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/latest',
        queryParameters: {'base': base},
      );
      final options = RequestOptions(
        path: uri.path,
        method: 'GET',
        queryParameters: uri.queryParameters,
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.throws(
          403,
          DioException(
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 403,
              requestOptions: options,
            ),
            requestOptions: options,
          ),
        ),
      );

      final rates = currencyBeaconService.getLatestRates(base: base);
      await expectLater(rates, throwsA(isA<AppException>()));
    });
  });

  group('Get historical rates', () {
    test('and return exchange rates when base and date are not null', () async {
      final uri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/historical',
        queryParameters: {
          'base': base,
          'date': date,
        }..addAll(accessKey),
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.reply(200, cbHistoricalRatesPayload),
      );

      final rates = await currencyBeaconService.getHistoricalRates(
        base: base,
        date: date,
      );
      expect(rates, ExchangeRates.fromCurrencyBeacon(cbHistoricalRatesPayload));
    });

    test('and throw exception', () async {
      final uri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/historical',
        queryParameters: {'base': base, 'date': date},
      );
      final options = RequestOptions(
        path: uri.path,
        method: 'GET',
        queryParameters: uri.queryParameters,
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.throws(
          403,
          DioException(
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 403,
              requestOptions: options,
            ),
            requestOptions: options,
          ),
        ),
      );

      final rates = currencyBeaconService.getHistoricalRates(
        base: base,
        date: date,
      );
      await expectLater(rates, throwsA(isA<AppException>()));
    });
  });
}
