import 'dart:math' as math;

import 'package:flutter/widgets.dart';

extension IterableExtensions<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback has index as second argument
  Iterable<T> mapIndex<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

/// Allows to insert a separator between the items of the iterable.
extension SeparatedIterable on Iterable<Widget> {
  /// Allows to insert a [separator] between the items of the iterable.
  List<Widget> separatedBy(Widget separator) {
    final result = <Widget>[];
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      result.add(iterator.current);
      while (iterator.moveNext()) {
        result
          ..add(separator)
          ..add(iterator.current);
      }
    }
    return result;
  }
}

extension MinMaxExtensions on Iterable<double> {
  double get max => reduce(math.max);

  double get min => reduce(math.min);
}
