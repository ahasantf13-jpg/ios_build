import 'package:dio/dio.dart';
import 'package:beautygm/core/errors/exceptions/http_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/network_exceptions.dart';
import 'package:beautygm/core/errors/exceptions/server_exceptions.dart';
import 'package:beautygm/core/errors/models/error_model.dart';

Never handleDioException(DioException e) {
  final ErrorModel error = _extractErrorModel(e);

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(error);

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(error);

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(error);

    case DioExceptionType.connectionError:
      throw ConnectionErrorException(error);

    case DioExceptionType.badCertificate:
      throw BadCertificateException(error);

    case DioExceptionType.cancel:
      throw CancelException(error);

    case DioExceptionType.badResponse:
      throw _mapStatusCode(e.response?.statusCode, error);

    case DioExceptionType.unknown:
    // ignore: unreachable_switch_default
    default:
      throw UnknownNetworkException(error);
  }
}

ErrorModel _extractErrorModel(DioException e) {
  final dynamic data = e.response?.data;

  try {
    if (data == null) {
      return ErrorModel(
        errorMessage: e.message ?? 'Unexpected error occurred',
      );
    }

    if (data is String) {
      return ErrorModel(
        errorMessage: data,
      );
    }

    if (data is Map<String, dynamic>) {
      return ErrorModel.fromJson(
        data,
      );
    }

    return ErrorModel(
      errorMessage: data.toString(),
    );
  } catch (_) {
    return ErrorModel(
      errorMessage: e.message ?? 'Unexpected error occurred',
    );
  }
}

ServerException _mapStatusCode(int? statusCode, ErrorModel error) {
  if (statusCode == null) {
    return ServerException(error);
  }

  switch (statusCode) {
    case 400:
      return BadRequestException(error);
    case 401:
      return UnauthorizedException(error);
    case 403:
      return ForbiddenException(error);
    case 404:
      return NotFoundException(error);
    case 409:
      return ConflictException(error);
    case 422:
      return UnprocessableEntityException(error);
    case 429:
      return TooManyRequestsException(error);
  }

  if (statusCode >= 500) {
    return InternalServerErrorException(error);
  }

  return ServerException(error);
}
