part of 'preference_bloc.dart';

abstract class PreferenceEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class PreferenceInitialize extends PreferenceEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class PreferenceThemeChanged extends PreferenceEvent {
  PreferenceThemeChanged({required this.newValue});

  final AppThemeType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class PreferenceLanguageChanged extends PreferenceEvent {
  PreferenceLanguageChanged({required this.newValue});

  final AppLanguageType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}

class PreferenceAutoThemeModeChanged extends PreferenceEvent {
  PreferenceAutoThemeModeChanged({required this.newValue});

  final AutoThemeModeType newValue;

  @override
  List<Object?> get props => <Object?>[newValue];
}
