import 'package:tractian_challenge/core/utils/constants/assets.dart';

base class SensorType {
  SensorType({required this.value, this.asset});

  final String value;
  final String? asset;
}

final class Vibration extends SensorType {
  Vibration() : super(value: 'vibration');
}

final class Energy extends SensorType {
  Energy() : super(value: 'energy', asset: Assets.energy);
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
