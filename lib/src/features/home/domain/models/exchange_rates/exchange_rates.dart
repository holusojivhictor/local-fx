import 'package:equatable/equatable.dart';

class ExchangeRates extends Equatable {
  const ExchangeRates({
    required this.timestamp,
    required this.base,
    required this.date,
    required this.rates,
  });

  ExchangeRates.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'] as int,
        base = json['base'] as String,
        date = json['date'] as String,
        rates = Map<String, num>.from(json['rates'] as Map);

  final int timestamp;
  final String base;
  final String date;
  final Map<String, num> rates;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'timestamp': timestamp,
      'base': base,
      'date': date,
      'rates': rates,
    };
  }

  @override
  List<Object?> get props => <Object?>[
    timestamp,
    base,
    date,
    rates,
  ];
}
