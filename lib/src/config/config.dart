import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  Config._();

  static final Config _singleton = Config._();

  static Config get instance => _singleton;

  void initConfig(Map<String, RemoteConfigValue> values) {
    fastForexApiKey = values['fast_forex_api_key']?.asString() ?? '';
    currencyBeaconApiKey = values['currency_beacon_api_key']?.asString() ?? '';
    twelveDataApiKey = values['twelve_data_api_key']?.asString() ?? '';
  }

  static String fastForexApiKey = '';

  static String currencyBeaconApiKey = '';

  static String twelveDataApiKey = '';
}
