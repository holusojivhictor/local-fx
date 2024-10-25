import 'package:get_it/get_it.dart';
import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';
import 'package:local_fx/src/features/common/infrastructure/network_client.dart';
import 'package:local_fx/src/features/home/infrastructure/exchange_rates_service.dart';
import 'package:local_fx/src/features/home/infrastructure/fixer_service.dart';
import 'package:local_fx/src/features/home/infrastructure/local_fx_service.dart';

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

    final exchangeRatesService = ExchangeRatesService(networkClient);
    getIt.registerSingleton<ExchangeRatesService>(exchangeRatesService);

    final fixerService = FixerService(networkClient);
    getIt.registerSingleton<FixerService>(fixerService);

    final localFxService = LocalFXService();
    getIt.registerSingleton<LocalFXService>(localFxService);
  }
}
