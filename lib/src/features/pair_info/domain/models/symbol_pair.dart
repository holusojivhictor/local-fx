import 'package:equatable/equatable.dart';

class SymbolPair extends Equatable {
  const SymbolPair({
    required this.symbol,
    required this.currencyBase,
    required this.currencyQuote,
  });

  SymbolPair.fromJson(Map<String, dynamic> json)
      : symbol = json['symbol'] as String,
        currencyBase = json['currency_base'] as String,
        currencyQuote = json['currency_quote'] as String;

  final String symbol;
  final String currencyBase;
  final String currencyQuote;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'symbol': symbol,
      'currency_base': currencyBase,
      'currency_quote': currencyQuote,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    symbol,
    currencyBase,
    currencyQuote,
  ];
}
