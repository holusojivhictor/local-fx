part of 'pair_info_cubit.dart';

class PairInfoState extends Equatable {
  const PairInfoState({
    required this.base,
    required this.symbol,
    required this.loadingQuote,
    this.quote,
  });

  const PairInfoState.init({
    required this.base,
    required this.symbol,
  })  : quote = null,
        loadingQuote = false;

  final String base;
  final String symbol;
  final Quote? quote;
  final bool loadingQuote;

  String get pair => '$base/$symbol';

  PairInfoState copyWith({
    Quote? quote,
    bool? loadingQuote,
  }) {
    return PairInfoState(
      base: base,
      symbol: symbol,
      quote: quote ?? this.quote,
      loadingQuote: loadingQuote ?? this.loadingQuote,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        base,
        symbol,
        quote,
        loadingQuote,
      ];
}
