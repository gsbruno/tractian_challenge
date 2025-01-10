import 'package:flutter/material.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/expandable_button.dart';

class TreeList extends StatelessWidget {
  const TreeList({super.key, required this.tree});

  final Map<String, Node> tree;

  @override 
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tree.length,
      itemBuilder: (context, index) {
        return ExpandableButton(node: tree.values.elementAt(index));
      },
    );
  }
}
