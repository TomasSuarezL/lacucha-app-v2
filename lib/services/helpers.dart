import 'package:intl/intl.dart';

bool isSameDay(DateTime date1, DateTime date2) {
  return DateFormat('yMd').format(date1) == DateFormat('yMd').format(date2);
}
