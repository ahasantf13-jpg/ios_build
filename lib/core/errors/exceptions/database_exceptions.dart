import 'package:beautygm/core/errors/exceptions/app_exceptions.dart';

abstract class DatabaseException extends AppException {
  const DatabaseException(super.error);
}

class DatabaseReadException extends DatabaseException {
  const DatabaseReadException(super.error);
}

class DatabaseWriteException extends DatabaseException {
  const DatabaseWriteException(super.error);
}
