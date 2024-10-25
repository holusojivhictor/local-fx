import 'package:local_fx/src/config/env.dart';

class Config {
  factory Config() => _singleton;

  Config._internal();

  static final Config _singleton = Config._internal();

  static final String exchangeRatesApiKey = Env.exchangeRatesApiKey;

  static final String fixerApiKey = Env.fixerApiKey;
}
