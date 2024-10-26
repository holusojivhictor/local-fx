import 'package:local_fx/src/config/config.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/domain/services/forex_service.dart';

class FastForexService extends ForexService {
  FastForexService(this._client);

  final NetworkClient _client;

  static Map<String, String> accessKey = {
    'api_key': Config.fastForexApiKey,
  };

  @override
  Future<ExchangeRates?> getLatestRates({required String base}) async {
    final result = await _client.get<JsonMap, ExchangeRates>(
      Uri(
        scheme: 'https',
        host: Constants.fastForexHost,
        path: '/fetch-all',
        queryParameters: {'from': base}..addAll(accessKey),
      ),
      transform: ExchangeRates.fromFastForex,
      onError: _rethrowAppError,
    );

    return result;
  }

  @override
  Future<ExchangeRates?> getHistoricalRates({
    required String date,
    required String base,
  }) async {
    final result = await _client.get<JsonMap, ExchangeRates>(
      Uri(
        scheme: 'https',
        host: Constants.fastForexHost,
        path: '/historical',
        queryParameters: {
          'from': base,
          'date': date,
        }..addAll(accessKey),
      ),
      transform: ExchangeRates.fromFastForex,
      onError: _rethrowAppError,
    );

    return result;
  }

  void _rethrowAppError(AppException err) {
    throw err;
  }
}
