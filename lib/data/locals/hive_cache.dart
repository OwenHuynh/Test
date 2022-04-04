import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/data/locals/models/employee/employee_model.dart';
import 'package:hive/hive.dart';

class HiveCache {
  HiveCache._();

  static final HiveCache _instance = HiveCache._();

  static HiveCache get instance => _instance;

  static bool boxIsClosed(Box box) => !box.isOpen;

  Future<void> initHive() async {
    registerHiveTypeAdapters();
  }

  void registerHiveTypeAdapters() {
    Hive
      ..registerAdapter(EmployeeModelAdapter())
      ..registerAdapter(DistrictModelAdapter());
  }
}
