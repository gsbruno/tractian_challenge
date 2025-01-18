import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

class CalculateVisibleItemsUsecase
    extends UseCase<Map<String, bool>, CalculateVisibleItemsUsecaseParams> {
  @override
  FutureOutput<Map<String, bool>> call(
      {CalculateVisibleItemsUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    final visibleNodes = <String, bool>{};

    for (final node in params.nodes) {
      // If the filter is active, show all nodes expanded
      if (params.isEnergyFilterActive ||
          params.isStatusFilterActive ||
          params.searchText.isNotEmpty) {
        if (node.hasChildren) {
          visibleNodes[node.id] = true;
        } else {
          visibleNodes[node.id] = false;
        }
        // Else show only the root nodes collapsed
      } else if (node.isRoot) {
        visibleNodes[node.id] = false;
      }
    }
    return (null, visibleNodes);
  }
}

final class CalculateVisibleItemsUsecaseParams extends Params {
  final bool isEnergyFilterActive;
  final bool isStatusFilterActive;
  final String searchText;

  final List<Node> nodes;

  CalculateVisibleItemsUsecaseParams(
      {required this.isEnergyFilterActive,
      required this.isStatusFilterActive,
      required this.searchText,
      required this.nodes});
}
