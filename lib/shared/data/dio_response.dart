import 'package:dio/dio.dart';
import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/errors/remote_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';

extension ResposeEither on Future<Response<Json>> {
  Future<Json> solve() async {
    try {
      final response = await this;

      return switch (response.statusCode) {
        200 || 201 || 202 || 204 => response.data ?? {},
        _ => throw BadResponse(response.statusCode ?? 999),
      };
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw NetworkFailure();
        case DioExceptionType.unknown:
          throw UnexpectedLocalError(stackTrace: error.stackTrace);
        default:
          throw RemoteError.fromCode(error.response?.statusCode ?? 999);
      }
    }
  }
}

extension ResposeListEither on Future<Response<List>> {
  Future<List> solve() async {
    try {
      final response = await this;

      return switch (response.statusCode) {
        200 || 201 || 202 || 204 => response.data ?? [],
        _ => throw BadResponse(response.statusCode ?? 999),
      };
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          throw NetworkFailure();
        case DioExceptionType.unknown:
          throw UnexpectedLocalError(stackTrace: error.stackTrace);
        default:
          throw RemoteError.fromCode(error.response?.statusCode ?? 999);
      }
    }
  }
}
