import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DeviceInfoService,
  LoggingService,
  PreferenceService,
  FastForexService,
  CurrencyBeaconService,
])
void main() {}
