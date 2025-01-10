import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/shared/data/model.dart';

final class AssetModel extends Model<AssetModel> {
  AssetModel({
    required super.id,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.locationId,
  });

  factory AssetModel.from(Json json) => AssetModel(
    id: json['id'],
    name: json['name'],
    parentId: json['parentId'],
    sensorId: json['sensorId'],
    sensorType: json['sensorType'],
    status: json['status'],
    gatewayId: json['gatewayId'],
    locationId: json['locationId'],
  );

  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  bool get isComponent => sensorType != null;
}