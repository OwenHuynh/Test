import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';

class MockEffect extends Mock {
  VoidCallback? call();
}

class MockWidgetBuild extends Mock {
  void call();
}

class MockDispose extends Mock {
  void call();
}
