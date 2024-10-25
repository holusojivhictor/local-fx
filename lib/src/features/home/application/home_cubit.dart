import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_fx/src/features/common/domain/constants.dart';
import 'package:local_fx/src/features/common/domain/models/models.dart';
import 'package:local_fx/src/features/common/presentation/bloc_presentation/bloc_presentation_mixin.dart';
import 'package:local_fx/src/features/home/infrastructure/local_fx_service.dart';
import 'package:local_fx/src/utils/location_utils.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState>
    with BlocPresentationMixin<HomeState, HomeCubitEvent> {
  HomeCubit(this._fxService) : super(const HomeState.init());

  final LocalFXService _fxService;

  Future<void> init() async {
    try {
      await handlePermission();

      final isoCountryCode = await _fxService.getIsoCountryCodeFromPosition();
      if (isoCountryCode == null) return;

      final country = _fxService.getCountryFromIsoCode(isoCountryCode);
      onCountryChanged(country);
    } catch (_) {
      // Use fallback country
      onCountryChanged(fallbackCountry);
      emitPresentation(
        const CountryFromPositionError(
          'Could not get supported country. Using (USA) as fallback',
        ),
      );
    }
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
}

sealed class HomeCubitEvent {}

class CountryFromPositionError implements HomeCubitEvent {
  const CountryFromPositionError(this.error);

  final String error;
}
