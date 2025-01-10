import 'package:tractian_challenge/core/utils/constants/assets.dart';

base class Status {
  Status({required this.value, this.asset});

  final String value; 
  final String? asset;
}

final class Alert extends Status {
  Alert() : super(value: 'alert', asset: Assets.alert);
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
