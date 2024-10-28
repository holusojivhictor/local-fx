import 'package:flutter_test/flutter_test.dart';
import 'package:local_fx/src/features/home/application/home_cubit.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

import '../../mocks.mocks.dart';

void main() {
  late FastForexService fastForexService;
  late CurrencyBeaconService currencyBeaconService;
  late LocalFXService localFXService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    fastForexService = MockFastForexService();
    currencyBeaconService = MockCurrencyBeaconService();
    localFXService = LocalFXService(fastForexService, currencyBeaconService);
  });

  test('Initial state', () {
    expect(HomeCubit(localFXService).state, HomeState.init());
  });
}
