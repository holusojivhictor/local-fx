import 'package:intl/intl.dart';

String get yesterday {
  return DateTime.now().subtract(const Duration(hours: 24)).basic;
}

extension DateTimeExtensions on DateTime {
  DateTime get now => DateTime.now();

  String get basic {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
