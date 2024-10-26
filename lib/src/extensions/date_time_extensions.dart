import 'package:intl/intl.dart';

String get yesterday {
  return DateTime.now().subtract(const Duration(hours: 24)).basic;
}

extension DateTimeExtensions on DateTime {
  DateTime get now => DateTime.now();

  String get prettyTime {
    return DateFormat('h:mm a').format(this);
  }

  String get prettyUTC {
    return toUtc().prettyTime;
  }

  String get basic {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get fullUS {
    final dateFormat = DateFormat.yMMMMd('en_US');
    return dateFormat.format(this);
  }
}
