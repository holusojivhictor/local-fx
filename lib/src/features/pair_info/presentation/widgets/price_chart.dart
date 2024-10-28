import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:local_fx/src/extensions/extensions.dart';
import 'package:local_fx/src/features/pair_info/domain/models/candlestick.dart';

class PriceChart extends StatelessWidget {
  const PriceChart({required this.candlesticks, super.key});

  final List<Candlestick> candlesticks;

  @override
  Widget build(BuildContext context) {
    final values =
        candlesticks.expand((e) => [e.low, e.close, e.open, e.high]).toList();
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      height: 500,
      child: Chart<Candlestick>(
        rebuild: false,
        data: candlesticks.reversed.toList(),
        variables: {
          'datetime': Variable(
            accessor: (Candlestick datum) =>
                '${datum.datetime.chartDay} ${datum.datetime.chartTime}',
            scale: OrdinalScale(tickCount: 3),
          ),
          'close': Variable(
            accessor: (Candlestick datum) => datum.close as num,
            scale: LinearScale(min: values.min, tickCount: 5),
          ),
        },
        marks: [
          LineMark(
            size: SizeEncode(value: 1),
          ),
        ],
        axes: [
          Defaults.horizontalAxis
            ..line = null,
          Defaults.verticalAxis
            ..gridMapper =
                (_, index, __) => index == 0 ? null : Defaults.strokeStyle,
        ],
        selections: {
          'touchMove': PointSelection(
            on: {
              GestureType.scaleUpdate,
              GestureType.tapDown,
              GestureType.longPressMoveUpdate,
            },
            dim: Dim.x,
          ),
        },
        crosshair: CrosshairGuide(
          labelPaddings: [0.0, 0.0],
          showLabel: [true, true],
          followPointer: [false, false],
          styles: [
            PaintStyle(strokeColor: onSurface),
            PaintStyle(strokeColor: onSurface),
          ],
        ),
      ),
    );
  }
}
