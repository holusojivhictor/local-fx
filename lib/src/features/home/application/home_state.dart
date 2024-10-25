part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.country,
    required this.currencyPairs,
    required this.hasLocationPermission,
    required this.loadingRates,
  });

  HomeState.init()
      : country = fallbackCountry,
        currencyPairs = const <Pair>[],
        hasLocationPermission = false,
        loadingRates = false;

  final Country country;
  final List<Pair> currencyPairs;
  final bool hasLocationPermission;
  final bool loadingRates;

  HomeState copyWith({
    Country? country,
    List<Pair>? currencyPairs,
    bool? hasLocationPermission,
    bool? loadingRates,
  }) {
    return HomeState(
      country: country ?? this.country,
      currencyPairs: currencyPairs ?? this.currencyPairs,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      loadingRates: loadingRates ?? this.loadingRates,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    country,
    currencyPairs,
    hasLocationPermission,
    loadingRates,
  ];
}
