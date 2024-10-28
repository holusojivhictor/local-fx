import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:local_fx/src/features/home/application/home_cubit.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';

import '../../common.dart';
import '../../helpers.dart';
import '../../mocks.mocks.dart';

void main() {
  const geolocatorChannel = MethodChannel('flutter.baseflow.com/geolocator');

  late FastForexService fastForexService;
  late CurrencyBeaconService currencyBeaconService;
  late LocalFXService localFXService;

  Future<dynamic> geolocatorHandler(MethodCall methodCall) async {
    if (methodCall.method == 'getCurrentPosition') {
      return mockPosition.toJson();
    }

    if (methodCall.method == 'isLocationServiceEnabled') {
      return true;
    }

    if (methodCall.method == 'checkPermission') {
      return 3;
    }
  }

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(geolocatorChannel, geolocatorHandler);
    GeocodingPlatform.instance = MockGeocodingPlatform();

    fastForexService = MockFastForexService();
    currencyBeaconService = MockCurrencyBeaconService();
    localFXService = LocalFXService(fastForexService, currencyBeaconService);
  });

  test('Initial state', () {
    expect(HomeCubit(localFXService).state, HomeState.init());
  });

  blocTest<HomeCubit, HomeState>(
    'emits initialized state',
    build: () => HomeCubit(localFXService),
    act: (cubit) => cubit.init(),
    skip: 2,
    expect: () {
      return <HomeState>[
        const HomeState(
          country: mockCountry,
          currencyPairs: [],
          hasLocationPermission: true,
          loadingRates: true,
        ),
      ];
    },
  );
}
