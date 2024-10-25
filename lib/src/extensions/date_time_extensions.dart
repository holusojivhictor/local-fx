import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  DateTime get now => DateTime.now();

  String get basic {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
