import 'package:equatable/equatable.dart';

class Candlestick extends Equatable {
  const Candlestick({
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  Candlestick.fromJson(Map<String, dynamic> json)
      : datetime = DateTime.parse(json['datetime'] as String),
        open = double.parse(json['open'] as String),
        high = double.parse(json['high'] as String),
        low = double.parse(json['low'] as String),
        close = double.parse(json['close'] as String);

  final DateTime datetime;
  final double open;
  final double high;
  final double low;
  final double close;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'datetime': datetime.toString(),
      'open': open.toString(),
      'high': high.toString(),
      'low': low.toString(),
      'close': close.toString(),
    };
  }

  @override
  List<Object?> get props => <Object?>[
    datetime,
    open,
    high,
    low,
    close,
  ];
}
