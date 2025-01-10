import 'package:tractian_challenge/core/utils/constants/assets.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';

final class Location extends Node {
  Location({required super.id, required super.name, super.parentId});

  @override
  String get asset => Assets.location;

  @override
  String toString() => 'name: $name, isRoot: $isRoot, isLeaf: $isLeaf';
}
