import 'package:equatable/equatable.dart';

class Language extends Equatable {
  const Language(this.code, this.countryCode);

  final String code;
  final String countryCode;

  @override
  List<Object?> get props => <Object?>[code, countryCode];
}
