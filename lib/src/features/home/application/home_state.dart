part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.country,
    required this.hasLocationPermission,
  });

  const HomeState.init()
      : country = null,
        hasLocationPermission = false;

  final Country? country;
  final bool hasLocationPermission;

  HomeState copyWith({
    Country? country,
    bool? hasLocationPermission,
  }) {
    return HomeState(
      country: country ?? this.country,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    country,
    hasLocationPermission,
  ];
}
