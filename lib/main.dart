import 'dart:async';
import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:portal/application/application.dart';
import 'package:portal/data/locals/hive_cache.dart';
import 'package:portal/di/dependency_injection.dart' as dependencyInjection;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

Future<void> main() async {
  await initApp();
  runApp(await Application());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  BaseGlobal()..pushStyle = RoutePushStyle.SlideLeftWithFade;
  await dependencyInjection.configureInjection();
  await Hive.initFlutter();
  await HiveCache.instance.initHive();
  Intl.defaultLocale = 'ja';
}
