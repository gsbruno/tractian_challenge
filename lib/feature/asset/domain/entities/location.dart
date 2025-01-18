import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/utils/constants/tractian_icons_icons.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';

final class Location extends Node {
  Location({required super.id, required super.name});

  @override
  IconData get asset => TractianIcons.location;
}
