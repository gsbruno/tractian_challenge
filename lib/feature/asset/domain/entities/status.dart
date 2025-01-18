import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/utils/constants/tractian_icons_icons.dart';

base class Status {
  Status({required this.value, this.asset});

  final String value;
  final IconData? asset;

  @override
  String toString() => 'Status($value)';
}

final class Alert extends Status {
  Alert() : super(value: 'alert', asset: TractianIcons.alert);
}

final class Operating extends Status {
  Operating() : super(value: 'operating');
}

final class Unavailable extends Status {
  Unavailable(String value) : super(value: value);
}

extension StatusExtension on String? {
  Status get status => switch (this) {
        'alert' => Alert(),
        'operating' => Operating(),
        _ => Unavailable(this ?? 'null'),
      };
}
