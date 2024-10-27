import 'package:local_fx/src/extensions/date_time_extensions.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';

abstract class ForexService {
  Future<ExchangeRates?> getLatestRates({required String base});

  Future<ExchangeRates?> getHistoricalRates({
    required String date,
    required String base,
  });

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
        final absolute = latestRate - pastRate;
        final change = (absolute / pastRate) * 100;

        return Pair(
          base: base,
          quote: pair,
          rate: latestRate,
          change: change,
          absolute: absolute,
          date: latestRates.date,
        );
      }).toList();
    } on AppException catch (e) {
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
