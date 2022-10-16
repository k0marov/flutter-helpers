import 'package:flutter/foundation.dart';

void printDebug(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}

DateTime fromUnixSec(int unixSec) {
  // No conversion to UTC since Unix time is already UTC
  return DateTime.fromMillisecondsSinceEpoch(unixSec * 1000);
}

int toUnixSec(DateTime dt) => (dt.toUtc().millisecondsSinceEpoch / 1000).floor();
