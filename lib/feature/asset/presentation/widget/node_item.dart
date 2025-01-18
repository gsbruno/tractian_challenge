import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';

class NodeItem extends StatelessWidget {
  const NodeItem({
    super.key,
    required this.height,
    required this.isOpen,
    required this.node,
    required this.isLast,
  });

  final double height;
  final bool isOpen;
  final Node node;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...depthIndicator,
        _arrow,
        _icon,
        _name,
        _energyStatus,
        _alertStatus,
      ],
    );
  }

  List<Widget> get depthIndicator => List.generate(node.depth,
      (index) => Container(height: height, width: 1, color: AppColors.grey2));

  Widget get _arrow => node.hasChildren ? _arrowState : const SizedBox.shrink();

  Widget get _arrowState => isOpen ? _arrowDown : _arrowForward;

  Widget get _arrowDown => Transform.rotate(
        angle: pi / 2, // 180 degrees in radians
        child: _arrowForward,
      );

  Widget get _arrowForward => Icon(Icons.arrow_forward_ios, size: height);

  Widget get _icon => Icon(
        node.asset,
        color: AppColors.blue,
        size: height,
      );

  Widget get _name => Text(
        node.name,
        style: TextStyle(fontSize: height),
      );

  Widget get _energyStatus => node.isLeaf && node.hasEnergy
      ? Icon(
          Icons.bolt_rounded,
          color: AppColors.green,
          size: height,
        )
      : const SizedBox.shrink();

  Widget get _alertStatus => node.isLeaf && node.hasAlert
      ? Icon(
          Icons.circle,
          color: AppColors.red,
          size: height * 0.6,
        )
      : const SizedBox.shrink();
}
