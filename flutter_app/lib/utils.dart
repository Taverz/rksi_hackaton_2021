import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return ' $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    return '$date';
  }
}
