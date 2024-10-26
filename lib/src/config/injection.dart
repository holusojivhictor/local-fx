import 'package:get_it/get_it.dart';
import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final deviceInfoService = DeviceInfoService();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingService();
    getIt.registerSingleton<LoggingService>(loggingService);

    final preferenceService = PreferenceService(loggingService);
    await preferenceService.init();
    getIt.registerSingleton<PreferenceService>(preferenceService);

    final localeService = LocaleService(preferenceService);
    getIt.registerSingleton<LocaleService>(localeService);

    final networkClient = NetworkClient(loggingService);
    getIt.registerSingleton<NetworkClient>(networkClient);

    final fastForexService = FastForexService(networkClient);
    getIt.registerSingleton<FastForexService>(fastForexService);

    final currencyBeaconService = CurrencyBeaconService(networkClient);
    getIt.registerSingleton<CurrencyBeaconService>(currencyBeaconService);

    final localFxService = LocalFXService();
    getIt.registerSingleton<LocalFXService>(localFxService);
  }
}
