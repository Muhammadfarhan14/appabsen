// void log(String tag, msg) {
//   print('Error: $msg');
// }

import 'package:flutter/foundation.dart';

class Log {
  static void debug(msg) {
    if (kDebugMode) {
      print('[d] $msg');
    }
  }

  static void error(msg) {
    if (kDebugMode) {
      print('[e] $msg');
    }
  }
}