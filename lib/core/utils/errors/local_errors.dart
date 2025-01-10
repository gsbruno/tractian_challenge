import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/utils/errors/commom_errors.dart';

abstract base class LocalError extends CommomError {
  const LocalError({required super.message});

  @override
  String displayName(BuildContext context);
}

final class NoResultError extends LocalError {
  const NoResultError() : super(message: 'No result');

  @override
  String displayName(BuildContext context) => 'No result';
}

final class SelectStatusError extends LocalError {
  const SelectStatusError() : super(message: 'Error selecting status');

  @override
  String displayName(BuildContext context) => 'Error selecting status';
}

final class NetworkFailure extends LocalError {
  NetworkFailure() : super(message: 'Network failure');

  @override
  String displayName(BuildContext context) => 'Network failure';
}

final class UnexpectedLocalError extends LocalError {
  UnexpectedLocalError({this.stackTrace = null, String? message})
      : super(message: message ?? 'Unexpected failure');

  final StackTrace? stackTrace;

  @override
  String displayName(BuildContext context) => 'Unexpected failure';
}

final class UnimplementedError extends LocalError {
  UnimplementedError() : super(message: 'Not implemented');

  @override
  String displayName(BuildContext context) => 'Not implemented';
}

final class FieldNotFound extends LocalError {
  FieldNotFound(String field, String className)
      : super(message: 'Field $field not found in $className');

  @override
  String displayName(BuildContext context) => 'Field not found';
}

final class NoMatchingValue extends LocalError {
  NoMatchingValue(this.value) : super(message: 'No matching value: $value');

  final String value;

  @override
  String displayName(BuildContext context) => 'No matching value';
}
