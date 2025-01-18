import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/utils/constants/tractian_icons_icons.dart';

base class SensorType {
  SensorType({required this.value, this.asset});

  final String value;
  final IconData? asset;

  @override
  String toString() => 'SensorType($value)';
}

final class Vibration extends SensorType {
  Vibration() : super(value: 'vibration');
}

final class Energy extends SensorType {
  Energy() : super(value: 'energy', asset: TractianIcons.energy);
}

final class Unknown extends SensorType {
  Unknown(String value) : super(value: value);
}

extension SensorTypeExtension on String? {
  SensorType get sensorType => switch (this) {
        'vibration' => Vibration(),
        'energy' => Energy(),
        _ => Unknown(this ?? 'null'),
      };
}
