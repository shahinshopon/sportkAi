import 'package:intl/intl.dart';

String formatMatchDateTime(String matchDatetimeString) {
    DateTime matchDatetime = DateTime.parse(matchDatetimeString);
    return DateFormat('dd MMM yyyy, hh:mm a').format(matchDatetime);
  }