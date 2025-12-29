import 'dart:async';
import 'package:flutter/foundation.dart';

/// Utility class to debounce rapid function calls
/// Useful for search inputs to avoid excessive API calls
class Debouncer {
  Debouncer({required this.duration});

  final Duration duration;
  Timer? _timer;

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}