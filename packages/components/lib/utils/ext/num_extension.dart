import 'dart:math' as math;
import 'package:flutter/services.dart';

extension ExtensionNum on num {
  T max<T extends num>(T value) => math.max(this as T, value);

  T min<T extends num>(T value) => math.min(this as T, value);

  double get cos => math.cos(this);

  double get tan => math.tan(this);

  double get aCos => math.acos(this);

  double get aSin => math.asin(this);

  double get sqrt => math.sqrt(this);

  double get exp => math.exp(this);

  double get log => math.log(this);

  double aTan2(num value) => math.atan2(this, value);

  Future<void> get toClipboard async =>
      Clipboard.setData(ClipboardData(text: toString()));

  List<T> generate<T>(T Function(int index) generator,
          {bool growable = true}) =>
      List<T>.generate(toInt(), (int index) => generator(index),
          growable: growable);

  String padLeft(int width, [String padding = ' ']) =>
      toString().padLeft(width, padding);

  int get length => toString().length;

  DateTime? fromMicrosecondsSinceEpoch({bool isUtc = false}) {
    num n = this;
    if (n is! int) {
      n = n.toInt();
    }
    if (n.toString().length != 16) {
      return null;
    }
    return DateTime.fromMicrosecondsSinceEpoch(n, isUtc: isUtc);
  }

  DateTime? fromMillisecondsSinceEpoch({bool isUtc = false}) {
    num n = this;
    if (n is! int) {
      n = n.toInt();
    }
    if (n.toString().length != 13) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(n, isUtc: isUtc);
  }

  bool contains(Pattern other, [int startIndex = 0]) =>
      toString().contains(other);

  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
}

extension ExtensionInt on int {
  int rightShift32(int n) => ((toInt() & 0xFFFFFFFF) >> n).toSigned(32);

  int leftShift32(int n) => ((toInt() & 0xFFFFFFFF) << n).toSigned(32);
}
