import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/utils/constants/tractian_icons_icons.dart';

base class Node {
  Node(
      {required this.id,
      required this.name,
      this.parentId,
      List<Node>? children})
      : children = children ?? [];

  final String id;
  final String name;
  final String? parentId;

  final List<Node> children;

  Node? parentNode;
  int depth = 0;

  void addChild(Node child) {
    child.changeDepth(depth + 1);
    children.add(child);
  }

  void changeDepth(int newDepth) {
    if (depth == newDepth) return;
    depth = newDepth;

    for (var child in children) {
      child.changeDepth(depth + 1);
    }
  }

  String? get parent => parentId;

  bool get isRoot => parent == null;

  bool get hasChildren => children.isNotEmpty;

  bool get isLeaf => children.isEmpty;

  bool get hasAlert => children.any((child) => child.hasAlert);

  bool get hasEnergy => children.any((child) => child.hasEnergy);

  List<Node> get flat => [this, ...children.expand((child) => child.flat)];

  bool hasText(String text) =>
      name.toLowerCase().contains(text.toLowerCase()) ||
      children.any((child) => child.hasText(text));

  IconData get asset => TractianIcons.asset;

  @override
  String toString() => 'parent: $parent, depth: $depth';
}
