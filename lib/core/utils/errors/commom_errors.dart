import 'package:flutter/material.dart';

abstract base class CommomError {
  const CommomError({required this.message});

  final String message;

  String displayName(BuildContext context);
}
