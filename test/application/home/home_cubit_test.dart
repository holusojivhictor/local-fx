import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:local_fx/src/features/home/application/home_cubit.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';
import 'package:mockito/mockito.dart';

import '../../common.dart';
import '../../helpers.dart';
import '../../mocks.mocks.dart';

void main() {
  const geolocatorChannel = MethodChannel('flutter.baseflow.com/geolocator');
  const base = 'EUR';

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
    when(fastForexService.getLatestRatesWithChanges(base: base))
        .thenAnswer((_) async => pairs);
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
    skip: 3,
    expect: () {
      return <HomeState>[
        HomeState(
          country: mockCountry,
          currencyPairs: pairs,
          hasLocationPermission: true,
          loadingRates: false,
        ),
      ];
    },
  );
}

final pairs = <Pair>[
  Pair(
    base: 'AUD',
    quote: 'HUF',
    rate: 228.633442,
    absolute: 1.3345,
    change: 0.11,
    date: DateTime.now(),
  ),
];
