import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/models.dart';
import 'package:local_fx/src/features/common/presentation/bloc_presentation/bloc_presentation_mixin.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/exchange_rates_service.dart';
import 'package:local_fx/src/features/home/infrastructure/fixer_service.dart';
import 'package:local_fx/src/features/home/infrastructure/local_fx_service.dart';
import 'package:local_fx/src/utils/location_utils.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState>
    with BlocPresentationMixin<HomeState, HomeCubitEvent> {
  HomeCubit(
    this._fxService,
    this._exchangeRatesService,
    this._fixerService,
  ) : super(HomeState.init());

  final LocalFXService _fxService;
  final ExchangeRatesService _exchangeRatesService;
  final FixerService _fixerService;

  Future<void> init() async {
    try {
      emit(state.copyWith(loadingRates: true));
      await handlePermission();

      final isoCountryCode = await _fxService.getIsoCountryCodeFromPosition();
      if (isoCountryCode == null) return;

      final country = _fxService.getCountryFromIsoCode(isoCountryCode);
      onCountryChanged(country);
    } catch (_) {
      // Use fallback country
      emitPresentation(
        LocaleFetchError(
          'Could not get supported country. Using (${fallbackCountry.name}) as fallback',
        ),
      );
    }

    return refreshLocalRates();
  }

  Future<void> handlePermission() async {
    try {
      await LocationUtils.handlePermission();
      emit(state.copyWith(hasLocationPermission: true));
    } catch (_) {}
  }

  void onCountryChanged(Country country) {
    emit(state.copyWith(country: country));
  }

  Future<void> refreshLocalRates([String? code]) async {
    final currencyCode = code ?? state.country.currencyCode;

    try {
      final pairs = await _exchangeRatesService.getLatestRatesWithChanges(
        base: currencyCode,
      );

      emit(state.copyWith(currencyPairs: pairs, loadingRates: false));
    } catch (_) {
      try {
        final pairs = await _fixerService.getLatestRatesWithChanges(
          base: currencyCode,
        );
        emit(state.copyWith(currencyPairs: pairs, loadingRates: false));
      } catch (_) {
        final fallbackCode = fallbackCountry.currencyCode;
        if (currencyCode != fallbackCode) {
          emitPresentation(
            LocaleFetchError(
              'Could not get rates for $currencyCode. Loading rates for ${fallbackCountry.isoCode}($fallbackCode) as fallback',
            ),
          );

          onCountryChanged(fallbackCountry);
          await refreshLocalRates(fallbackCode);
        }

        emit(state.copyWith(loadingRates: false));
      }
    }
  }
}

sealed class HomeCubitEvent {}

class LocaleFetchError implements HomeCubitEvent {
  const LocaleFetchError(this.error);

  final String error;
}
