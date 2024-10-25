import 'package:local_fx/src/config/config.dart';
import 'package:local_fx/src/extensions/date_time_extensions.dart';
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
    final result = await _client.get<JsonMap, ExchangeRates>(
      Uri.https(
        Constants.fixerAuthority,
        '/api/$date',
        {'base': base}..addAll(accessKey),
      ),
      transform: ExchangeRates.fromJson,
      onError: _rethrowAppError,
    );

    return result;
  }

  @override
  Future<ExchangeRates?> getLatestRates({required String base}) async {
    final result = await _client.get<JsonMap, ExchangeRates>(
      Uri.https(
        Constants.fixerAuthority,
        '/api/latest',
        {'base': base}..addAll(accessKey),
      ),
      transform: ExchangeRates.fromJson,
      onError: _rethrowAppError,
    );

    return result;
  }

  @override
  Future<List<Pair>> getLatestRatesWithChanges({
    required String base,
  }) async {
    try {
      final latestRates = await getLatestRates(base: base);
      final pastRates = await getHistoricalRates(date: yesterday, base: base);

      if (latestRates == null || pastRates == null) return [];

      return latestRates.rates.entries
          .where((entry) => pastRates.rates.containsKey(entry.key))
          .map((entry) {
        final pair = entry.key;
        final latestRate = entry.value;
        final pastRate = pastRates.rates[pair]!;
        final change = ((latestRate - pastRate) / pastRate) * 100;

        return Pair(
          pair: pair,
          rate: latestRate,
          change: change,
          timestamp: latestRates.timestamp,
        );
      }).toList();
    }  on AppException catch (e) {
      _rethrowAppError(e);
    } catch (e) {
      _rethrowAppError(AppException.getAppException(e));
    }

    return [];
  }

  void _rethrowAppError(AppException err) {
    throw err;
  }
}
