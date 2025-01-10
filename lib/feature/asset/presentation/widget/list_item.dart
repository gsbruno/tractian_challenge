import 'package:flutter/material.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/asset.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/component.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/sensor_type.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/status.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.node});

  final Node node;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Image.asset(node.asset, width: 34, height: 34),
          const SizedBox(width: 8),
          Text(node.name),
          const SizedBox(width: 8),
          _statusIcon(),
          const SizedBox(width: 8),
          _energyIcon(),
        ],
      );
  }

  Widget _statusIcon() {
    switch (node) {
      case Component(:Alert status):
        return Image.asset(status.asset ?? '', width: 21, height: 21);
      case Asset(:Alert status):
        return Image.asset(status.asset ?? '', width: 21, height: 21);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _energyIcon() {
    switch (node) {
      case Component(:Energy sensorType):
        return Image.asset(sensorType.asset ?? '', width: 21, height: 21);
      default:
        return const SizedBox.shrink();
    }
  }
}
