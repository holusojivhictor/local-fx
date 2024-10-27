import 'package:equatable/equatable.dart';

class ExchangeRates extends Equatable {
  const ExchangeRates({
    required this.base,
    required this.date,
    required this.rates,
  });

  factory ExchangeRates.fromFastForex(Map<String, dynamic> json) {
    final updated = json['updated'] as String?;
    final date = json['date'] as String?;

    return ExchangeRates(
      base: json['base'] as String,
      date: DateTime.parse(updated ?? date!),
      rates: Map<String, num>.from(json['results'] as Map),
    );
  }

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
    required this.base,
    required this.quote,
    required this.rate,
    required this.absolute,
    required this.change,
    required this.date,
  });

  Pair.fake()
      : base = 'AUD',
        quote = 'HUF',
        rate = 228.633442,
        absolute = 1.3345,
        change = 0.11,
        date = DateTime.now();

  final String base;
  final String quote;
  final num rate;
  final num absolute;
  final double change;
  final DateTime date;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'base': base,
      'pair': quote,
      'rate': rate,
      'absolute': absolute,
      'change': change,
      'date': date.toIso8601String(),
    };
  }

  String get pair => '$base$quote';

  @override
  List<Object?> get props => <Object?>[
        base,
        quote,
        rate,
        absolute,
        change,
        date,
      ];
}
