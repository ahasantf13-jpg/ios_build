import 'package:dartz/dartz.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/locations/domain/repositories/locations_repository.dart';

class DeleteLocationUsecase {
  final LocationsRepository repository;

  DeleteLocationUsecase({required this.repository});

  Future<Either<Failure, void>> call({required DeleteLocationParams params}) {
    return repository.deleteLocation(params: params);
  }
}
