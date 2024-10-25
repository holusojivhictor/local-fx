import 'package:local_fx/src/config/config.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/domain/services/forex_service.dart';

class FixerService implements ForexService {
  FixerService(this._client);

  final NetworkClient _client;

  static Map<String, String> accessKey = {
    'access_key': Config.fixerApiKey,
  };

  @override
  Future<ExchangeRates?> getHistoricalRates({
    required String date,
    required String base,
  }) async {
    final result = _client.get<JsonMap, ExchangeRates>(
      Uri(
        path: Constants.fixerBaseUrl + date,
        queryParameters: {'base': base}..addAll(accessKey),
      ),
      transform: ExchangeRates.fromJson,
      onError: _rethrowAppError,
    );

    return result;
  }

  @override
  Future<ExchangeRates?> getLatestRates({required String base}) async {
    final result = _client.get<JsonMap, ExchangeRates>(
      Uri(
        path: '${Constants.fixerBaseUrl}latest',
        queryParameters: {'base': base}..addAll(accessKey),
      ),
      transform: ExchangeRates.fromJson,
      onError: _rethrowAppError,
    );

    return result;
  }

  void _rethrowAppError(AppException err) {
    throw err;
  }
}
