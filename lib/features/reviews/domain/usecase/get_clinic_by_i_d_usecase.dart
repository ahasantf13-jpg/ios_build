import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/clinics/domain/entities/clinic_entity.dart';
import 'package:beautygm/features/reviews/domain/repos/reviews_repository.dart';
import 'package:dartz/dartz.dart';

class GetClinicByIDUsecase {
  final ReviewsRepository repository;

  GetClinicByIDUsecase({required this.repository});

  Future<Either<Failure, ClinicEntity>> call({
    required GetClinicByIDParams params,
  }) {
    return repository.getClinicByID(params: params);
  }
}
