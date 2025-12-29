import 'package:dio/dio.dart';

sealed class NetworkException implements Exception {
  const NetworkException(this.message);
  
  final String message;
  
  factory NetworkException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        return ServerException(statusCode);
      case DioExceptionType.cancel:
        return const CancelException();
      default:
        return const UnknownException();
    }
  }
  
  @override
  String toString() => message;
}

class TimeoutException extends NetworkException {
  const TimeoutException() 
      : super('Connection timeout. Please check your internet connection.');
}

class ServerException extends NetworkException {
  final int statusCode;
  
  const ServerException(this.statusCode) 
      : super('Server error ($statusCode). Please try again later.');
}

class CancelException extends NetworkException {
  const CancelException() : super('Request was cancelled.');
}

class UnknownException extends NetworkException {
  const UnknownException() 
      : super('An unexpected error occurred. Please try again.');
}