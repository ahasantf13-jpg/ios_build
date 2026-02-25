import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/features/notifications/domain/entities/notification_entity.dart';
import 'package:beautygm/features/notifications/domain/repos/notification_repository.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUsecase {
  final NotificationRepository repository;

  GetNotificationsUsecase({required this.repository});

  Future<Either<Failure, List<NotificationEntity>>> call() {
    return repository.getCurrentUserNotifications();
  }
}
