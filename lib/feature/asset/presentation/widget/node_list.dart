import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';

class NodeListItem extends StatefulWidget {
  const NodeListItem({
    super.key,
    required this.isOpen,
    required this.node,
    required this.height,
    required this.onTap,
  });

  final bool isOpen;
  final Node node;
  final double height;
  final void Function(Node) onTap;

  @override
  State<NodeListItem> createState() => _NodeListItemState();
}

class _NodeListItemState extends State<NodeListItem> {
  double get _objectHeight => widget.height * 0.7;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        onTap: widget.node.hasChildren ? () => widget.onTap(widget.node) : null,
        title: Row(
          children: [
            ..._depthIndicator,
            _isLastChild ? _lastDepthIndicator : const SizedBox.shrink(),
            _arrow,
            const SizedBox(width: 8),
            _icon,
            const SizedBox(width: 8),
            _name,
            _energyStatus,
            _alertStatus,
          ],
        ),
      ),
    );
  }

  bool get _isLastChild => widget.node.isLeaf && !widget.node.isRoot;

  List<Widget> get _depthIndicator => List.generate(
      widget.node.depth,
      (index) => Container(
          margin: EdgeInsets.only(left: _objectHeight / 2),
          height: widget.height,
          width: 1,
          color: AppColors.grey2));

  Widget get _lastDepthIndicator => Container(
        margin: EdgeInsets.only(top: widget.height - 1),
        height: 1,
        width: _objectHeight / 2,
        color: AppColors.grey2,
      );

  Widget get _arrow =>
      widget.node.hasChildren ? _arrowState : const SizedBox.shrink();

  Widget get _arrowState => !widget.isOpen ? _arrowForward : _arrowDown;

  Widget get _arrowDown => Transform.rotate(
        angle: pi / 2, // 180 degrees in radians
        child: _arrowForward,
      );

  Widget get _arrowForward =>
      Icon(Icons.arrow_forward_ios, size: _objectHeight);

  Widget get _icon => Icon(
        widget.node.asset,
        color: AppColors.blue,
        size: _objectHeight,
      );

  Widget get _name => Text(
        widget.node.name,
        style: TextStyle(fontSize: _objectHeight),
      );

  Widget get _energyStatus => widget.node.isLeaf && widget.node.hasEnergy
      ? Icon(
          Icons.bolt_rounded,
          color: AppColors.green,
          size: _objectHeight,
        )
      : const SizedBox.shrink();

  Widget get _alertStatus => widget.node.isLeaf && widget.node.hasAlert
      ? Icon(
          Icons.circle,
          color: AppColors.red,
          size: _objectHeight * 0.6,
        )
      : const SizedBox.shrink();
}
