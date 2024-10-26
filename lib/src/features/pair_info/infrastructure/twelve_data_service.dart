import 'package:local_fx/src/config/config.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/pair_info/domain/enums/interval.dart';
import 'package:local_fx/src/features/pair_info/domain/models/models.dart';

class TwelveDataService {
  TwelveDataService(this._client);

  final NetworkClient _client;

  static Map<String, String> accessKey = {
    'apikey': Config.twelveDataApiKey,
  };

  Future<Quote?> getQuoteFromSymbol({required String symbol}) async {
    final result = await _client.get<JsonMap, Quote>(
      Uri(
        scheme: 'https',
        host: Constants.twelveDataHost,
        path: 'quote',
        queryParameters: {'symbol': symbol}..addAll(accessKey),
      ),
      transform: Quote.fromJson,
      onError: _rethrowAppError,
    );

    return result;
  }

  Future<List<Candlestick>> getTimeSeriesData({
    required String symbol,
    required PointInterval interval,
    String outputSize = '500',
  }) async {
    final result = await _client.get<JsonMap, List<Candlestick>>(
      Uri(
        scheme: 'https',
        host: Constants.twelveDataHost,
        path: 'time_series',
        queryParameters: {
          'symbol': symbol,
          'interval': interval.value,
          'outputsize': outputSize,
        }..addAll(accessKey),
      ),
      transform: (data) {
        return (data['values'] as List<dynamic>)
            .map((e) => Candlestick.fromJson(e as Map<String, dynamic>))
            .toList();
      },
      onError: _rethrowAppError,
    );

    return result ?? [];
  }

  void _rethrowAppError(AppException err) {
    throw err;
  }
}
