import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';

abstract class CacheException extends AppException {
  const CacheException(super.error);
}

class CacheReadException extends CacheException {
  const CacheReadException(super.error);
}

class CacheWriteException extends CacheException {
  const CacheWriteException(super.error);
}

class CacheDeleteException extends CacheException {
  const CacheDeleteException(super.error);
}
