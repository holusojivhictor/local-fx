import 'package:local_fx/src/config/config.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/exception/app_exception.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
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

  void _rethrowAppError(AppException err) {
    throw err;
  }
}
