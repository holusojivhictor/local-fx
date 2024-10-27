import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

import '../helpers.dart';
import '../mocks.mocks.dart';

void main() {
  final dio = Dio();
  late DioAdapter dioAdapter;
  late NetworkClient networkClient;
  late FastForexService fastForexService;
  late CurrencyBeaconService currencyBeaconService;
  late LocalFXService localFXService;

  setUp(() {
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
}
