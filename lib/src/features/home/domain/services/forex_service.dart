import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';

abstract class ForexService {
  Future<ExchangeRates?> getLatestRates({required String base});

  Future<ExchangeRates?> getHistoricalRates({
    required String date,
    required String base,
  });

  Future<List<Pair>> getLatestRatesWithChanges({required String base});
}
