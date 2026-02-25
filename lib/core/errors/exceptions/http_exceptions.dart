import 'package:beautygm/core/errors/exceptions/server_exceptions.dart';

class BadRequestException extends ServerException {
  const BadRequestException(super.error);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.error);
}

class ForbiddenException extends ServerException {
  const ForbiddenException(super.error);
}

class NotFoundException extends ServerException {
  const NotFoundException(super.error);
}

class ConflictException extends ServerException {
  const ConflictException(super.error);
}

class UnprocessableEntityException extends ServerException {
  const UnprocessableEntityException(super.error);
}

class TooManyRequestsException extends ServerException {
  const TooManyRequestsException(super.error);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException(super.error);
}
