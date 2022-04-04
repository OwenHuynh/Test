import 'package:portal/data/repositories-impl/auth_repository_impl/auth_repository_impl.dart';
import 'package:portal/data/repositories-impl/district_repository_impl/district_repository_impl.dart';
import 'package:portal/domain/repositories/auth_repository/auth_repository.dart';
import 'package:portal/domain/repositories/district_repository/district_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection() async {
  getIt

    /// [REPOSITORIES]
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl())
    ..registerLazySingleton<DistrictRepository>(() => DistrictRepositoryImpl());
}
