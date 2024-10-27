part of 'pair_info_cubit.dart';

class PairInfoState extends Equatable {
  const PairInfoState({
    required this.base,
    required this.symbol,
    required this.candlesticks,
    required this.availablePairs,
    required this.failedDataFetch,
    required this.loadingQuote,
    required this.loadingTimeSeries,
    this.quote,
  });

  const PairInfoState.init({
    required this.base,
    required this.symbol,
  })  : quote = null,
        candlesticks = const <Candlestick>[],
        availablePairs = const <SymbolPair>[],
        failedDataFetch = false,
        loadingQuote = false,
        loadingTimeSeries = false;

  final String base;
  final String symbol;
  final Quote? quote;
  final List<Candlestick> candlesticks;
  final List<SymbolPair> availablePairs;
  final bool failedDataFetch;
  final bool loadingQuote;
  final bool loadingTimeSeries;

  String get pair => '$base/$symbol';

  PairInfoState copyWith({
    Quote? quote,
    List<Candlestick>? candlesticks,
    List<SymbolPair>? availablePairs,
    bool? failedDataFetch,
    bool? loadingQuote,
    bool? loadingTimeSeries,
  }) {
    return PairInfoState(
      base: base,
      symbol: symbol,
      quote: quote ?? this.quote,
      candlesticks: candlesticks ?? this.candlesticks,
      availablePairs: availablePairs ?? this.availablePairs,
      failedDataFetch: failedDataFetch ?? this.failedDataFetch,
      loadingQuote: loadingQuote ?? this.loadingQuote,
      loadingTimeSeries: loadingTimeSeries ?? this.loadingTimeSeries,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        base,
        symbol,
        quote,
        candlesticks,
        availablePairs,
        failedDataFetch,
        loadingQuote,
        loadingTimeSeries,
      ];
}
