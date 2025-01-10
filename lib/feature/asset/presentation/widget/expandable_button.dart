import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/list_item.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/tree_list.dart';

class ExpandableButton extends StatefulWidget {
  const ExpandableButton({
    required this.node,
    super.key,
  });

  final Node node;

  @override
  State<ExpandableButton> createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      onTap: _canExpand ? _toggleExpanded : null,
      title: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 34),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _content,
              _additionalContent,
            ],
          ),
        ),
    );
  }

  Widget get _content => Row(
        children: [
          _canExpand ? _arrow : const SizedBox(width: 29),
          const SizedBox(width: 8),
          ListItem(node: widget.node),
        ],
      );

  Widget get _additionalContent =>
      _isExpanded
          ? Padding(
              padding: const EdgeInsets.only(left: 29),
              child: TreeList(tree: widget.node.children),
            )
          : const SizedBox.shrink();

  bool get _canExpand => widget.node.children.isNotEmpty;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget get _arrow => _isExpanded ? _arrowDown : _arrowForward;

  Widget get _arrowDown => Transform.rotate(
    angle: pi / 2, // 180 degrees in radians
    child: _arrowForward,
  );

  Widget get _arrowForward =>const Icon(Icons.arrow_forward_ios, size: 21);
}
