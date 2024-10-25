import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'EXCHANGE_RATES_API_KEY', obfuscate: true)
  static final String exchangeRatesApiKey = _Env.exchangeRatesApiKey;

  @EnviedField(varName: 'FIXER_API_KEY', obfuscate: true)
  static final String fixerApiKey = _Env.fixerApiKey;
}
