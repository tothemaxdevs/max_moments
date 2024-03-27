import 'package:dio/dio.dart';

class ErrorState {}

String handleError(Error error) {
  String errorDescription = "";
  if (error is DioException) {
    DioException dioException = error as DioException;
    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        errorDescription = "No internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.connectionError:
        errorDescription =
            "Received invalid status code: ${dioException.response!.statusCode}";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection with API server";
        break;
      case DioExceptionType.badCertificate:
        errorDescription = "Bad certificate";
        break;
      case DioExceptionType.badResponse:
        errorDescription =
            "Received invalid status code: ${dioException.response!.statusCode}";
        break;
    }
  } else {
    errorDescription = "Unexpected error occured";
  }
  return errorDescription;
}

String handleErrorDio(DioException dioException) {
  String errorDescription = "";
  switch (dioException.type) {
    case DioExceptionType.cancel:
      errorDescription = "Request to API server was cancelled";
      break;
    case DioExceptionType.sendTimeout:
      errorDescription = "Connection timeout with API server";
      break;
    case DioExceptionType.unknown:
      errorDescription = "No internet connection";
      break;
    case DioExceptionType.receiveTimeout:
      errorDescription = "Receive timeout in connection with API server";
      break;
    case DioExceptionType.connectionError:
      errorDescription =
          "Received invalid status code: ${dioException.response!.statusCode}";
      break;
    case DioExceptionType.connectionTimeout:
      errorDescription = "Connection with API server";
      break;
    case DioExceptionType.badCertificate:
      errorDescription = "Bad certificate";
      break;
    case DioExceptionType.badResponse:
      errorDescription =
          "Received invalid status code: ${dioException.response!.statusCode}";
      break;
  }
  return errorDescription;
}
