import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/shared/data/model.dart';

final class LocationModel extends Model<LocationModel> {
  LocationModel({
    required super.id,
    required this.name,
    required this.parentId,
  });

  factory LocationModel.from(Json json) => LocationModel(id: json['id'], name: json['name'], parentId: json['parentId']);

  final String name;
  final String? parentId;
}
