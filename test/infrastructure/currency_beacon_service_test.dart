import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/currency_beacon_service.dart';

import '../helpers.dart';
import '../mocks.mocks.dart';

void main() {
  const currencyBeaconHost = 'api.currencybeacon.com';
  const accessKey = <String, String>{'api_key': 'API_KEY'};
  const base = 'USD';

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
    test('return exchange rates when base is not null', () async {
      final uri = Uri(
        scheme: 'https',
        host: currencyBeaconHost,
        path: 'v1/latest',
        queryParameters: {'base': base}..addAll(accessKey),
      );

      dioAdapter.onGet(
        uri.toString(),
        (request) => request.reply(200, latestRatesPayload),
      );

      final rates = await currencyBeaconService.getLatestRates(base: base);
      expect(rates, ExchangeRates.fromCurrencyBeacon(latestRatesPayload));
    });
  });
}

const latestRatesPayload = {
  'date': '2024-10-27T20:06:43Z',
  'base': 'USD',
  'rates': {
    'LVL': 0.65075151,
    'LYD': 4.82656785,
    'MAD': 9.89618477,
    'MDL': 17.9656493,
    'MGA': 4617.09786063,
    'MGF': 23085.48930316,
  },
};
