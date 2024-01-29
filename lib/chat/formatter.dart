import 'package:intl/intl.dart';

abstract class Formatter {
  Formatter._();

  static String formatDateTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.format(dateTime);
  }
}
