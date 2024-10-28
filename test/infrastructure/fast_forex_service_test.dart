import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/fast_forex_service.dart';

import '../common.dart';
import '../helpers.dart';
import '../mocks.mocks.dart';

void main() {
  const fastForexHost = 'api.fastforex.io';
  const accessKey = <String, String>{'api_key': 'API_KEY'};
  const base = 'USD';
  const date = '2024-10-27';

  final dio = Dio();
  late DioAdapter dioAdapter;
  late NetworkClient networkClient;
  late FastForexService fastForexService;

  setUp(() {
    dioAdapter = DioAdapter(
      dio: dio,
      matcher: const CustomRequestMatcher(matchMethod: true),
    );

    final logger = MockLoggingService();
    networkClient = NetworkClient(logger, dio: dio);
    fastForexService = FastForexService(networkClient);
  });

  group('Get latest rates', () {
    test('and return exchange rates when base is not null', () async {
      final uri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/fetch-all',
        queryParameters: {'from': base}..addAll(accessKey),
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.reply(200, ffLatestRatesPayload),
      );

      final rates = await fastForexService.getLatestRates(base: base);
      expect(rates, ExchangeRates.fromFastForex(ffLatestRatesPayload));
    });

    test('and throw exception', () async {
      final uri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/fetch-all',
        queryParameters: {'from': base},
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

      final rates = fastForexService.getLatestRates(base: base);
      await expectLater(rates, throwsA(isA<AppException>()));
    });
  });

  group('Get historical rates', () {
    test('and return exchange rates when base and date are not null', () async {
      final uri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/historical',
        queryParameters: {
          'from': base,
          'date': date,
        }..addAll(accessKey),
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.reply(200, ffHistoricalRatesPayload),
      );

      final rates = await fastForexService.getHistoricalRates(
        base: base,
        date: date,
      );
      expect(rates, ExchangeRates.fromFastForex(ffHistoricalRatesPayload));
    });

    test('and throw exception', () async {
      final uri = Uri(
        scheme: 'https',
        host: fastForexHost,
        path: '/historical',
        queryParameters: {'from': base, 'date': date},
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

      final rates = fastForexService.getHistoricalRates(base: base, date: date);
      await expectLater(rates, throwsA(isA<AppException>()));
    });
  });
}
