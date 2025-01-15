import 'package:flutter/foundation.dart';
import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/asset.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/component.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/sensor_type.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/status.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/get_tree_usecase.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class FilterTreeUsecase
    extends UseCase<Map<String, Node>, FilterTreeUsecaseParams> {
  FilterTreeUsecase();

  @override
  Output<Map<String, Node>> call({FilterTreeUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    final filteredTreeMap = await compute(_filter, params);

    final result = await GetTreeUsecase()
        .call(params: GetTreeUsecaseParams(nodes: filteredTreeMap));

    return result;
  }

  Map<String, Node> _filter(FilterTreeUsecaseParams params) {
    List<Node> filteredTree = params.tree.values.toList();

    filteredTree = _filterByStatus(filteredTree, params.isStatusFilterActive);

    filteredTree = _filterByEnergy(filteredTree, params.isEnergyFilterActive);

    filteredTree = _filterByText(filteredTree, params.searchText);

    _addParent(filteredTree, params.tree);

    return _toMap(filteredTree);
  }

  List<Node> _filterByStatus(List<Node> tree, bool isActive) {
    if (!isActive) {
      return tree;
    }

    return tree
        .where((node) => switch (node) {
              Asset(status: Alert _) => true,
              Component(status: Alert _) => true,
              _ => false,
            })
        .toList();
  }

  List<Node> _filterByEnergy(List<Node> tree, bool isActive) {
    if (!isActive) {
      return tree;
    }

    return tree
        .where((node) => switch (node) {
              Component(sensorType: Energy _) => true,
              _ => false,
            })
        .toList();
  }

  List<Node> _filterByText(List<Node> tree, String text) {
    if (text.isEmpty) {
      return tree;
    }

    return tree
        .where((node) => node.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  void _addParent(List<Node> filteredTree, Map<String, Node> tree) {
    for (int i = 0; i < filteredTree.length; i++) {
      final node = filteredTree[i];

      node.clearChildren();

      switch (node) {
        case Node(:final parentId?):
          filteredTree.add(tree[parentId]!);
          break;
        case Component(:final locationId?):
          filteredTree.add(tree[locationId]!);
          break;
        case Asset(:final locationId?):
          filteredTree.add(tree[locationId]!);
          break;
        default:
          break;
      }
    }
  }

  Map<String, Node> _toMap(List<Node> filteredTree) {
    final filteredTreeMap = <String, Node>{};

    for (var node in filteredTree) {
      filteredTreeMap[node.id] = node;
    }

    return filteredTreeMap;
  }
}

final class FilterTreeUsecaseParams extends Params {
  FilterTreeUsecaseParams({
    required this.isEnergyFilterActive,
    required this.isStatusFilterActive,
    required this.searchText,
    required this.tree,
  });

  final bool isEnergyFilterActive;
  final bool isStatusFilterActive;
  final String searchText;
  final Map<String, Node> tree;
}
