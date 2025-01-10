import 'package:tractian_challenge/core/utils/constants/assets.dart';
import 'package:tractian_challenge/feature/asset/data/models/asset_model.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/sensor_type.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/status.dart';

final class Component extends Node {
  Component({
    required super.id,
    required super.name,
    super.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    this.gatewayId,
    this.locationId,
  });

  Component.fromModel(AssetModel asset) : this(
    id: asset.id, 
    name: asset.name,
    sensorId: asset.sensorId!,
    sensorType: asset.sensorType.sensorType,
    status: asset.status.status,
    gatewayId: asset.gatewayId,
    locationId: asset.locationId,
  );

  final String sensorId;
  final SensorType sensorType;
  final Status status;
  final String? gatewayId;
  final String? locationId;

  @override
  String get asset => Assets.component;

  @override
  bool get isRoot => parentId == null && locationId == null;

  @override
  String toString() => 'isRoot: $isRoot, isLeaf: $isLeaf, sensorType: ${sensorType.value}, status: ${status.value}';
}
