import 'package:get_it/get_it.dart';
import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';

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
  }
}
