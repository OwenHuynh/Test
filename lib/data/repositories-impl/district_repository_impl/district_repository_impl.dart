import 'package:dartz/dartz.dart';
import 'package:portal/data/locals/hive_cache.dart';
import 'package:portal/data/locals/hive_constants_keys.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/domain/repositories/district_repository/district_repository.dart';
import 'package:portal/shared/errors/errors.dart';
import 'package:hive/hive.dart';

class DistrictRepositoryImpl extends DistrictRepository {
  @override
  Future<Either<Failure, void>> addDistrict(DistrictModel district) async {
    final box =
        await Hive.openBox<DistrictModel>(HiveConstantsKeys.listDistrictBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.add(district));
  }

  @override
  Future<Either<Failure, void>> addAddress(String address) async {
    final box = await Hive.openBox<String>(HiveConstantsKeys.addressBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.put(HiveConstantsKeys.address, address));
  }

  @override
  Future<Either<Failure, String>> getAddress() async {
    final box = await Hive.openBox<String>(HiveConstantsKeys.addressBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(
        await box.get(HiveConstantsKeys.address, defaultValue: "") ?? "");
  }

  @override
  Future<Either<Failure, void>> deleteDistrictAt(int position) async {
    final box =
        await Hive.openBox<DistrictModel>(HiveConstantsKeys.listDistrictBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(await box.deleteAt(position));
  }

  @override
  Future<Either<Failure, List<DistrictModel>>> loadDistrictList() async {
    final box =
        await Hive.openBox<DistrictModel>(HiveConstantsKeys.listDistrictBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }
    final data = await box.values.toList().cast<DistrictModel>();
    return Right(data);
  }

  @override
  Future<DistrictModel> getCurrentDistrict() async {
    final box =
        await Hive.openBox<DistrictModel>(HiveConstantsKeys.currentDistrict);
    if (HiveCache.boxIsClosed(box)) {}
    final data = await box.values.first;

    return data;
  }

  @override
  Future<Either<Failure, void>> setCurrentDistrict(
      DistrictModel currentDistrict) async {
    final box =
        await Hive.openBox<DistrictModel>(HiveConstantsKeys.currentDistrict);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }

    return Right(
        await box.put(HiveConstantsKeys.currentDistrict, currentDistrict));
  }

  @override
  Future<Either<Failure, void>> initDistrictList(
      List<DistrictModel> districtList) async {
    final box =
        await Hive.openBox<DistrictModel>(HiveConstantsKeys.listDistrictBox);
    if (HiveCache.boxIsClosed(box)) {
      return Left(HiveFailure());
    }
    final data = await box.addAll(districtList);
    return Right(data);
  }
}
