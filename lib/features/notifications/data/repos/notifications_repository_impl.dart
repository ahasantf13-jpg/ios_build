import 'package:beautygm/core/connections/network_info.dart';
import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/cache_exceptions.dart';
import 'package:beautygm/core/errors/models/failure.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/features/notifications/data/source/notifications_local_data_source.dart';
import 'package:beautygm/features/notifications/data/source/notifications_remote_data_source.dart';
import 'package:beautygm/features/notifications/domain/entities/notification_entity.dart';
import 'package:beautygm/features/notifications/domain/entities/post_notificaiton_entity.dart';
import 'package:beautygm/features/notifications/domain/repos/notification_repository.dart';
import 'package:dartz/dartz.dart';

class NotificationsRepositoryImpl extends NotificationRepository {
  final NetworkInfo networkInfo;
  final NotificationsRemoteDataSource remoteDataSource;
  final NotificationsLocalDataSource localDataSource;

  NotificationsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<NotificationEntity>>>
      getCurrentUserNotifications() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNotifications = await remoteDataSource.getNotifications();

        await localDataSource.cacheNotifications(remoteNotifications);

        return Right(remoteNotifications);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      try {
        final localNotifications =
            await localDataSource.getCachedNotifications();

        return Right(localNotifications);
      } on CacheException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      }
    }
  }

  @override
  Future<Either<Failure, PostNotificaitonEntity>> postNotification({
    required NotificationParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final postNotification = await remoteDataSource.postNotification(
          params,
        );

        return Right(postNotification);
      } on AppException catch (e) {
        return Left(Failure(errMessage: e.error.errorMessage));
      } catch (_) {
        return Left(Failure(errMessage: "Something went wrong!"));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connections!"));
    }
  }
}
