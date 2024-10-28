import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/models.dart';
import 'package:local_fx/src/features/common/presentation/bloc_presentation/bloc_presentation_mixin.dart';
import 'package:local_fx/src/features/home/domain/models/exchange_rates.dart';
import 'package:local_fx/src/features/home/infrastructure/infrastructure.dart';
import 'package:local_fx/src/utils/location_utils.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState>
    with BlocPresentationMixin<HomeState, HomeCubitEvent> {
  HomeCubit(this._fxService) : super(HomeState.init());

  final LocalFXService _fxService;

  Future<void> init({bool silent = true}) async {
    try {
      emit(state.copyWith(loadingRates: true));
      await handlePermission(silent: silent);

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

  Future<void> handlePermission({bool silent = true}) async {
    try {
      await LocationUtils.handlePermission();
      emit(state.copyWith(hasLocationPermission: true));
    } catch (e) {
      if (silent) return;
      final error = e as AppException;
      emitPresentation(PermissionsError(AppException.getErrorMessage(error)));
    }
  }

  void onCountryChanged(Country? country) {
    emit(state.copyWith(country: country));
  }

  Future<void> refreshLocalRates({Country? country, bool silent = true}) async {
    if (!silent) {
      emit(state.copyWith(loadingRates: true));
    }

    onCountryChanged(country);
    final currencyCode = country?.currencyCode ?? state.country.currencyCode;

    try {
      final pairs = await _fxService.getPairsFromCurrencyCode(currencyCode);
      emit(state.copyWith(currencyPairs: pairs, loadingRates: false));
    } catch (e) {
      final error = e as AppException;
      emitPresentation(LocaleFetchError(AppException.getErrorMessage(error)));

      return refreshLocalRates(country: fallbackCountry);
    }
  }
}

sealed class HomeCubitEvent {}

class LocaleFetchError implements HomeCubitEvent {
  const LocaleFetchError(this.error);

  final String error;
}

class PermissionsError implements HomeCubitEvent {
  const PermissionsError(this.error);

  final String error;
}
