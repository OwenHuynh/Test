import 'package:dartz/dartz.dart';
import 'package:portal/data/locals/models/employee/employee_model.dart';
import 'package:portal/shared/errors/errors.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, List<EmployeeModel>>> getEmployeeList();

  Future<Either<Failure, void>> addEmployee(EmployeeModel employee);

  Future<Either<Failure, void>> updateEmployee(
      int position, EmployeeModel employee);

  Future<Either<Failure, void>> deleteEmployee(int position);

  Future<Either<Failure, void>> deleteAllEmployee();
}
