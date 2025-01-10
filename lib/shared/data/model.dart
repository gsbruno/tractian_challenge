import 'package:tractian_challenge/core/utils/types/types.dart';

abstract base class Model<T> {
  Model({required this.id});

  factory Model.from(Json json) => throw UnimplementedError();

  final String id;
}
