import 'package:equatable/equatable.dart';

class PairInfoPageArgs extends Equatable {
  const PairInfoPageArgs({
    required this.base,
    required this.symbol,
  });

  final String base;
  final String symbol;

  @override
  List<Object?> get props => <Object?>[
    base,
    symbol,
  ];
}
