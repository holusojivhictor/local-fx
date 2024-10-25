import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_fx/src/features/common/application/app/app_bloc.dart';
import 'package:local_fx/src/features/common/domain/enums/enums.dart';
import 'package:local_fx/src/features/common/infrastructure/infrastructure.dart';

part 'preference_event.dart';
part 'preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferenceBloc(
    this._preferenceService,
    this._deviceInfoService,
    this._appBloc,
  ) : super(const PreferenceState.init()) {
    on<PreferenceInitialize>(_onInit);
    on<PreferenceThemeChanged>(_onThemeChanged);
    on<PreferenceLanguageChanged>(_onLanguageChanged);
    on<PreferenceAutoThemeModeChanged>(_onAutoThemeModeTypeChanged);
  }

  final PreferenceService _preferenceService;
  final DeviceInfoService _deviceInfoService;
  final AppBloc _appBloc;

  void _onInit(PreferenceInitialize event, Emitter<PreferenceState> emit) {
    final preferences = _preferenceService.preferences;

    emit(
      const PreferenceState.init().copyWith(
        themeMode: preferences.themeMode,
        currentTheme: preferences.appTheme,
        currentLanguage: preferences.appLanguage,
        appVersion: _deviceInfoService.version,
      ),
    );
  }

  void _onThemeChanged(
    PreferenceThemeChanged event,
    Emitter<PreferenceState> emit,
  ) {
    if (event.newValue == _preferenceService.appTheme) {
      return emit(state);
    }
    _preferenceService.appTheme = event.newValue;
    _appBloc.add(AppThemeChanged(newValue: event.newValue));
    emit(state.copyWith(currentTheme: event.newValue));
  }

  void _onLanguageChanged(
    PreferenceLanguageChanged event,
    Emitter<PreferenceState> emit,
  ) {
    if (event.newValue == _preferenceService.language) {
      return emit(state);
    }
    _preferenceService.language = event.newValue;
    _appBloc.add(AppLanguageChanged(newValue: event.newValue));
    emit(state.copyWith(currentLanguage: event.newValue));
  }

  void _onAutoThemeModeTypeChanged(
    PreferenceAutoThemeModeChanged event,
    Emitter<PreferenceState> emit,
  ) {
    if (event.newValue == _preferenceService.autoThemeMode) {
      return emit(state);
    }
    _preferenceService.autoThemeMode = event.newValue;
    _appBloc.add(AppThemeModeChanged(newValue: event.newValue));
    emit(state.copyWith(themeMode: event.newValue));
  }

  bool get isFirstInstall => _preferenceService.isFirstInstall;
}
