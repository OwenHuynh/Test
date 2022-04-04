import 'package:cores/cores.dart';
import 'package:flutter/material.dart';

class LoggerUtils {
  static void printInfo(String text) {
    if (DeviceUtils.isIOS) {
      debugPrint('🟩 [INFO] = $text', wrapWidth: 1024);
    } else {
      debugPrint('\x1B[32m [INFO] = $text \x1B[0m', wrapWidth: 1024);
    }
  }

  // static void _printError(String text, {Object? v}) {
  //   final obj = v != null ? ":${v}" : "";
  //   debugPrint('\x1B[31m [❌] $text$obj \x1B[0m', wrapWidth: 1024);
  // }

  static void printInfoObject(String tag, Object? v) {
    final obj = v != null ? ":${v}" : "";
    if (DeviceUtils.isIOS) {
      debugPrint('🟩 [$tag] = $obj', wrapWidth: 1024);
    } else {
      debugPrint('\x1B[32m [$tag] = $obj \x1B[0m', wrapWidth: 1024);
    }
  }

  static void printErrorObject(String tag, Object? v) {
    final obj = v != null ? ":${v}" : "";

    if (DeviceUtils.isIOS) {
      debugPrint('🟥 [$tag] = $obj', wrapWidth: 1024);
    } else {
      debugPrint('\x1B[31m [$tag] $obj \x1B[0m', wrapWidth: 1024);
    }
  }
}
