import 'package:dartz/dartz.dart';
import 'package:portal/data/locals/models/district/district_model.dart';
import 'package:portal/shared/errors/errors.dart';

abstract class DistrictRepository {
  Future<Either<Failure, List<DistrictModel>>> loadDistrictList();

  Future<Either<Failure, void>> addDistrict(DistrictModel district);

  Future<Either<Failure, void>> deleteDistrictAt(int position);

  Future<Either<Failure, void>> addAddress(String address);

  Future<Either<Failure, String>> getAddress();

  Future<Either<Failure, void>> setCurrentDistrict(
      DistrictModel currentDistrict);

  Future<DistrictModel> getCurrentDistrict();

  Future<Either<Failure, void>> initDistrictList(
      List<DistrictModel> districtList);
}
