import 'package:intl/intl.dart';

String moneySign = '\$';
final String globalNumberPattern = r'^(0|[0-9][0-9]*)$';
final String doubleNumberPattern = r'^[0-9]+([0-9]/.[0-9][0-9]+)?$';
final dateFormat = DateFormat("d/MM/yyyy");
final dateTimeFormat = DateFormat("d/MM/yyyy h:m");
final String nowTime = dateFormat.format(DateTime.now());
final timeFormat = DateFormat("h:mm a");
