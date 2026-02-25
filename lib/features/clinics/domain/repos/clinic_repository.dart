import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ClinicRepository {
  Future<Either<Failure, List<ClinicEntity>>> getAllClinics();

  Future<Either<Failure, void>> createNewClinic({
    required CreateNewClinicParams params,
  });

  Future<Either<Failure, void>> admingApproveRejectClinic(
      {required AdminApproveRejectClinicParams params});
}
