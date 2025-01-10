import 'package:flutter/src/widgets/framework.dart';
import 'package:tractian_challenge/core/utils/errors/commom_errors.dart';

abstract base class RemoteError extends CommomError {
  RemoteError({required this.code, required super.message});

  final int code;

  static RemoteError fromCode(int code) => switch (code) {
        400 => BadRequest(),
        401 => Unauthorized(),
        403 => Forbidden(),
        404 => NotFound(),
        500 => InternalServerError(),
        502 => BadGateway(),
        503 => ServiceUnavailable(),
        _ => BadResponse(code),
      };

  String displayName(BuildContext context);
}

final class BadRequest extends RemoteError {
  BadRequest() : super(code: 400, message: 'Bad Request');

  @override
  String displayName(BuildContext context) => 'Bad Request';
}

final class Unauthorized extends RemoteError {
  Unauthorized() : super(code: 401, message: 'Unauthorized');

  @override
  String displayName(BuildContext context) => 'Unauthorized';
}

final class Forbidden extends RemoteError {
  Forbidden() : super(code: 403, message: 'Forbidden');
  @override
  String displayName(BuildContext context) => 'Forbidden';
}

final class NotFound extends RemoteError {
  NotFound() : super(code: 404, message: 'Not Found');
  @override
  String displayName(BuildContext context) => 'Not Found';
}

final class InternalServerError extends RemoteError {
  InternalServerError() : super(code: 500, message: 'Internal Server Error');
  @override
  String displayName(BuildContext context) => 'Internal Server Error';
}

final class BadGateway extends RemoteError {
  BadGateway() : super(code: 502, message: 'Bad Gateway');
  @override
  String displayName(BuildContext context) => 'Bad Gateway';
}

final class ServiceUnavailable extends RemoteError {
  ServiceUnavailable() : super(code: 503, message: 'Service Unavailable');
  @override
  String displayName(BuildContext context) => 'Service Unavailable';
}

final class BadResponse extends RemoteError {
  BadResponse(int code) : super(code: code, message: 'Unknown code $code');

  @override
  String displayName(BuildContext context) => 'Bad Response';
}
