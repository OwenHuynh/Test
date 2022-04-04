import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portal/di/dependency_injection.dart' as dependencyInjection;
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupDependencyInjection() async {
  await GetIt.I.reset();
  await dependencyInjection.configureInjection();
}

Future<void> setMockMethodsForUnitTests() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannel('plugins.flutter.io/path_provider_macos')
    ..setMockMethodCallHandler((methodCall) async {
      return ".";
    });

  await setupDependencyInjection();
  await Hive.initFlutter();
}
