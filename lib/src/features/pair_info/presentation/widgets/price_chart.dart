import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:local_fx/src/extensions/extensions.dart';
import 'package:local_fx/src/features/pair_info/domain/models/candlestick.dart';

class PriceChart extends StatelessWidget {
  const PriceChart({required this.candlesticks, super.key});

  final List<Candlestick> candlesticks;

  @override
  Widget build(BuildContext context) {
    final values = candlesticks.map((e) => e.low).toList()
      ..addAll(candlesticks.map((e) => e.close))
      ..addAll(candlesticks.map((e) => e.open))
      ..addAll(candlesticks.map((e) => e.high));
    final min = values.min;
    final max = values.max;

    return SizedBox(
      height: 500,
      child: Chart<Candlestick>(
        data: candlesticks.reversed.toList(),
        variables: {
          'datetime': Variable(
            accessor: (Candlestick datum) =>
                '${datum.datetime.chartDay} ${datum.datetime.chartTime}',
            scale: OrdinalScale(tickCount: 4),
          ),
          'open': Variable(
            accessor: (Candlestick datum) => datum.open as num,
            scale: LinearScale(min: min, max: max),
          ),
          'high': Variable(
            accessor: (Candlestick datum) => datum.high as num,
            scale: LinearScale(min: min, max: max),
          ),
          'low': Variable(
            accessor: (Candlestick datum) => datum.low as num,
            scale: LinearScale(min: min, max: max),
          ),
          'close': Variable(
            accessor: (Candlestick datum) => datum.close as num,
            scale: LinearScale(min: min, max: max),
          ),
        },
        marks: [
          CustomMark(
            shape: ShapeEncode(value: CandlestickShape()),
            position: Varset('datetime') *
                (Varset('open') +
                    Varset('high') +
                    Varset('low') +
                    Varset('close')),
            color: ColorEncode(
              encoder: (tuple) =>
                  (tuple['close'] as num) >= (tuple['open'] as num)
                      ? Colors.red
                      : Colors.green,
            ),
          ),
        ],
        axes: [
          Defaults.horizontalAxis,
          Defaults.verticalAxis,
        ],
        coord: RectCoord(
          horizontalRangeUpdater: Defaults.horizontalRangeEvent,
        ),
      ),
    );
  }
}
