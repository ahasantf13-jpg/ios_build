import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/notifications/domain/repos/notification_repository.dart';
import 'package:dartz/dartz.dart';

class PostNotification {
  final NotificationRepository repository;

  PostNotification({required this.repository});

  Future<Either<Failure, void>> call({
    required NotificationParams params,
  }) {
    return repository.postNotification(params: params);
  }
}
