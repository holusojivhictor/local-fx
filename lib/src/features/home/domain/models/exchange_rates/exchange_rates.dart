import 'package:equatable/equatable.dart';

class ExchangeRates extends Equatable {
  const ExchangeRates({
    required this.base,
    required this.date,
    required this.rates,
  });

  ExchangeRates.fromFastForex(Map<String, dynamic> json)
      : base = json['base'] as String,
        date = DateTime.parse(json['updated'] as String),
        rates = Map<String, num>.from(json['results'] as Map);

  ExchangeRates.fromCurrencyBeacon(Map<String, dynamic> json)
      : base = json['base'] as String,
        date = DateTime.parse(json['date'] as String),
        rates = Map<String, num>.from(json['rates'] as Map);

  final String base;
  final DateTime date;
  final Map<String, num> rates;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'base': base,
      'date': date,
      'rates': rates,
    };
  }

  @override
  List<Object?> get props => <Object?>[base, date, rates];
}

class Pair extends Equatable {
  const Pair({
    required this.pair,
    required this.rate,
    required this.absolute,
    required this.change,
    required this.date,
  });

  Pair.fake()
      : pair = 'AUDHUF',
        rate = 228.633442,
        absolute = 1.3345,
        change = 0.11,
        date = DateTime.now();

  final String pair;
  final num rate;
  final num absolute;
  final double change;
  final DateTime date;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pair': pair,
      'rate': rate,
      'absolute': absolute,
      'change': change,
      'date': date.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => <Object?>[
        pair,
        rate,
        absolute,
        change,
        date,
      ];
}
