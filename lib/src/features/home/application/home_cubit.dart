import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/models.dart';
import 'package:local_fx/src/features/common/presentation/bloc_presentation/bloc_presentation_mixin.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';
import 'package:local_fx/src/utils/location_utils.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState>
    with BlocPresentationMixin<HomeState, HomeCubitEvent> {
  HomeCubit(
    this._fxService,
    this._fastForexService,
    this._currencyBeaconService,
  ) : super(HomeState.init());

  final LocalFXService _fxService;
  final FastForexService _fastForexService;
  final CurrencyBeaconService _currencyBeaconService;

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

  Future<void> refreshLocalRates({String? code, bool silent = true}) async {
    if (!silent) {
      emit(state.copyWith(loadingRates: true));
    }
    final currencyCode = code ?? state.country.currencyCode;

    try {
      final pairs = await _fastForexService.getLatestRatesWithChanges(
        base: currencyCode,
      );

      emit(state.copyWith(currencyPairs: pairs, loadingRates: false));
    } catch (_) {
      try {
        final pairs = await _currencyBeaconService.getLatestRatesWithChanges(
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

          emit(state.copyWith(country: fallbackCountry, currencyPairs: []));
          await refreshLocalRates(code: fallbackCode);
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
