import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/asset.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/component.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class GetTreeUsecase extends UseCase<Map<String, Node>, GetTreeUsecaseParams> {
  GetTreeUsecase();

  @override
  Output<Map<String, Node>> call({GetTreeUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    _setParents(params.nodes);

    return (null, params.nodes);
  }

  void _setParents(Map<String, Node> tree) {
    for (var node in tree.values) {
      switch (node) {
        case Node(:final parentId?):
          tree[parentId]?.addChild(node);
          break;
        case Component(:final locationId?):
          tree[locationId]?.addChild(node);
          break;
        case Asset(:final locationId?):
          tree[locationId]?.addChild(node);
          break;
        default:
          break;
      }
    }
  }
}

final class GetTreeUsecaseParams extends Params {
  GetTreeUsecaseParams({required this.nodes});

  final Map<String, Node> nodes;
}
