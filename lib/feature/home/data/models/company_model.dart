import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/shared/data/model.dart';

final class CompanyModel extends Model<CompanyModel> {
  CompanyModel({
    required super.id,
    required this.name,
  });

  factory CompanyModel.from(Json json) => CompanyModel(id: json['id'], name: json['name']);

  final String name;
}
