import 'package:local_fx/src/config/env.dart';

class Config {
  factory Config() => _singleton;

  Config._internal();

  static final Config _singleton = Config._internal();

  static final String fastForexApiKey = Env.fastForexApiKey;

  static final String currencyBeaconApiKey = Env.currencyBeaconApiKey;
}
