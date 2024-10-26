import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FAST_FOREX_API_KEY', obfuscate: true)
  static final String fastForexApiKey = _Env.fastForexApiKey;

  @EnviedField(varName: 'CURRENCY_BEACON_API_KEY', obfuscate: true)
  static final String currencyBeaconApiKey = _Env.currencyBeaconApiKey;
}
