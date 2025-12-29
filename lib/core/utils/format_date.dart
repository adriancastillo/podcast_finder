import 'package:intl/intl.dart';

String formatDuration(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;

  if (hours > 0) {
    return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
  }
  return '$minutes min';
}

String formatDate(DateTime date) => DateFormat('MMM dd, yyyy').format(date);
