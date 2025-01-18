import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class FilterTreeUsecase
    extends UseCase<List<Node>, FilterTreeUsecaseParams> {
  FilterTreeUsecase();

  @override
  FutureOutput<List<Node>> call({FilterTreeUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    final filteredTreeMap = _filter(params);

    return (null, filteredTreeMap);
  }

  List<Node> _filter(FilterTreeUsecaseParams params) {
    Iterable<Node> filteredTree = params.fullTree.values;

    if (!params.isEnergyFilterActive &&
        !params.isStatusFilterActive &&
        params.searchText.isEmpty) {
      filteredTree = filteredTree.where((node) => node.isRoot);

      return filteredTree.expand((node) => node.flat).toList();
    }

    filteredTree = _filterByStatus(filteredTree, params.isStatusFilterActive);

    filteredTree = _filterByEnergy(filteredTree, params.isEnergyFilterActive);

    filteredTree = _filterByText(filteredTree, params.searchText);

    return filteredTree
        .expand((node) => node.flat)
        .where((node) =>
            (params.isEnergyFilterActive && node.hasEnergy) ||
            (params.isStatusFilterActive && node.hasAlert) ||
            (params.searchText.isNotEmpty && node.hasText(params.searchText)))
        .toList();
  }

  Iterable<Node> _filterByStatus(Iterable<Node> tree, bool isActive) {
    if (!isActive) {
      return tree;
    }

    return tree.where((node) => node.isRoot && node.hasAlert);
  }

  Iterable<Node> _filterByEnergy(Iterable<Node> tree, bool isActive) {
    if (!isActive) {
      return tree;
    }

    return tree.where((node) => node.isRoot && node.hasEnergy);
  }

  Iterable<Node> _filterByText(Iterable<Node> tree, String text) {
    if (text.isEmpty) {
      return tree;
    }

    return tree.where((node) => node.isRoot && node.hasText(text));
  }
}

final class FilterTreeUsecaseParams extends Params {
  FilterTreeUsecaseParams({
    required this.isEnergyFilterActive,
    required this.isStatusFilterActive,
    required this.searchText,
    required this.fullTree,
  });

  final bool isEnergyFilterActive;
  final bool isStatusFilterActive;
  final String searchText;
  final Map<String, Node> fullTree;
}
