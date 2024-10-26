import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  const Quote({
    required this.timestamp,
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.previousClose,
    required this.change,
    required this.percentChange,
    required this.fiftyTwoWeek,
    required this.isMarketOpen,
  });

  const Quote.fake()
      : timestamp = 1729891747,
        symbol = 'USD/AUD',
        name = 'US Dollar / Australian Dollar',
        exchange = 'Forex',
        datetime = '2024-10-26',
        open = '1.51438',
        high = '1.51470',
        low = '1.51375',
        close = '1.51423',
        previousClose = '1.51434',
        change = '-0.00010',
        percentChange = '-0.00680',
        isMarketOpen = false,
        fiftyTwoWeek = const FiftyTwoWeek.fake();

  Quote.fromJson(Map<String, dynamic> json)
      : timestamp = json['timestamp'] as int,
        symbol = json['symbol'] as String,
        name = json['name'] as String,
        exchange = json['exchange'] as String,
        datetime = json['datetime'] as String,
        open = json['open'] as String,
        high = json['high'] as String,
        low = json['low'] as String,
        close = json['close'] as String,
        previousClose = json['previous_close'] as String,
        change = json['change'] as String,
        percentChange = json['percent_change'] as String,
        fiftyTwoWeek = FiftyTwoWeek.fromJson(
          Map<String, dynamic>.from(json['fifty_two_week'] as Map),
        ),
        isMarketOpen = json['is_market_open'] as bool;

  final int timestamp;
  final String symbol;
  final String name;
  final String exchange;
  final String datetime;
  final String open;
  final String high;
  final String low;
  final String close;
  final String previousClose;
  final String change;
  final String percentChange;
  final FiftyTwoWeek fiftyTwoWeek;
  final bool isMarketOpen;

  DateTime get date => DateTime.parse(datetime);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'symbol': symbol,
      'name': name,
      'exchange': exchange,
      'datetime': datetime,
      'timestamp': timestamp,
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'previous_close': previousClose,
      'change': change,
      'percent_change': percentChange,
      'fifty_two_week': fiftyTwoWeek.toJson(),
      'is_market_open': isMarketOpen,
    };
  }

  @override
  List<Object?> get props => <Object?>[
        timestamp,
        symbol,
        name,
        exchange,
        datetime,
        open,
        high,
        low,
        close,
        previousClose,
        change,
        percentChange,
        fiftyTwoWeek,
        isMarketOpen,
      ];
}

class FiftyTwoWeek extends Equatable {
  const FiftyTwoWeek({
    required this.low,
    required this.high,
    required this.lowChange,
    required this.highChange,
    required this.lowChangePercent,
    required this.highChangePercent,
    required this.range,
  });

  const FiftyTwoWeek.fake()
      : low = '1.44071',
        high = '1.59469',
        lowChange = '0.07352',
        highChange = '-0.08046',
        lowChangePercent = '5.10298',
        highChangePercent = '-5.04525',
        range = '1.440715 - 1.594690';

  FiftyTwoWeek.fromJson(Map<String, dynamic> json)
      : low = json['low'] as String,
        high = json['high'] as String,
        lowChange = json['low_change'] as String,
        highChange = json['high_change'] as String,
        lowChangePercent = json['low_change_percent'] as String,
        highChangePercent = json['high_change_percent'] as String,
        range = json['range'] as String;

  final String low;
  final String high;
  final String lowChange;
  final String highChange;
  final String lowChangePercent;
  final String highChangePercent;
  final String range;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'low': low,
      'high': high,
      'low_change': lowChange,
      'high_change': highChange,
      'low_change_percent': lowChangePercent,
      'high_change_percent': highChangePercent,
      'range': range,
    };
  }

  @override
  List<Object?> get props => <Object?>[
        low,
        high,
        lowChange,
        highChange,
        lowChangePercent,
        highChangePercent,
        range,
      ];
}
