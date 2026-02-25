import 'package:beautygm/core/errors/exceptions/server_exceptions.dart';

class ConnectionTimeoutException extends ServerException {
  const ConnectionTimeoutException(super.error);
}

class SendTimeoutException extends ServerException {
  const SendTimeoutException(super.error);
}

class ReceiveTimeoutException extends ServerException {
  const ReceiveTimeoutException(super.error);
}

class ConnectionErrorException extends ServerException {
  const ConnectionErrorException(super.error);
}

class BadCertificateException extends ServerException {
  const BadCertificateException(super.error);
}

class CancelException extends ServerException {
  const CancelException(super.error);
}

class UnknownNetworkException extends ServerException {
  const UnknownNetworkException(super.error);
}
