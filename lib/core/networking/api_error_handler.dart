import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  late ApiErrorModel apiErrorModel;

  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      return dioExceptionHandlers(error);
    } else if (error is TypeError) {
      return ApiErrorModel(message: "Type Error: ${error.toString()}");
    } else {
      return ApiErrorModel(message: "Something went wrong");
    }
  }

  static ApiErrorModel dioExceptionHandlers(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return ApiErrorModel(message: "Connection error with the server");
      case DioExceptionType.connectionTimeout:
        return ApiErrorModel(message: "Connection timeout with the server");
      case DioExceptionType.receiveTimeout:
        return ApiErrorModel(
          message: "Timeout while receiving data from the server",
        );
      case DioExceptionType.sendTimeout:
        return ApiErrorModel(
          message: "Timeout while sending data to the server",
        );
      case DioExceptionType.cancel:
        return ApiErrorModel(message: "The request to the server was canceled");
      case DioExceptionType.unknown:
        return ApiErrorModel(message: "An unexpected error occurred");
      case DioExceptionType.badResponse:
        return _handleError(error.response?.data);
      default:
        return ApiErrorModel(message: "Something went wrong");
    }
  }

  static ApiErrorModel _handleError(dynamic errorResponse) {
    if (errorResponse == null) {
      return ApiErrorModel(message: "An unknown error occurred");
    }

    return ApiErrorModel(
      message:
          errorResponse["message"] ??
          errorResponse["error"] ??
          "An unknown error occurred",
      code: errorResponse["code"],
      errors: errorResponse['errors'],
    );
  }
}
