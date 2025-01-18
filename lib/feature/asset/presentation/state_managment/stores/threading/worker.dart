import 'dart:isolate';

import 'package:async/async.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/calculate_visible_items_usecase.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/filter_tree_usecase.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/get_all_nodes_usecase.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/messaging/isolate_result.dart';

/// Class responsible for managing all nodes. It keeps all nodes in memory for
/// the running isolate/thread. It also manages the loading and filtering of nodes.
class Worker {
  final Map<String, Node> allNodes = {};

  // Used to cancel the loading of all nodes when necessary
  CancelableOperation<Output<Map<String, Node>>>? _loadNodesOperation;

  // Used to cancel the filtering of nodes when necessary. For example, when the user
  // changes the filter, we cancel the previous filtering operation and start a new one.
  CancelableOperation<Output<List<Node>>>? _filterNodesOperation;

  // Used to cancel the calculation of visible nodes when necessary. For example, when the user
  // changes the filter, we cancel the previous calculation operation and start a new one.
  CancelableOperation<Output<Map<String, bool>>>?
      _calculateVisibleNodesOperation;

  bool get _isLoading =>
      _loadNodesOperation != null &&
      !(_loadNodesOperation?.isCompleted ?? true);

  bool get _isFiltering =>
      _filterNodesOperation != null &&
      !(_filterNodesOperation?.isCompleted ?? true);

  Future<void> loadAllNodes(String companyId,
      {ReceivePort? mainThreadOutputPort}) async {
    try {
      // If the nodes are already loading, do nothing
      if (_isLoading) {
        return;
      }

      // Cancel the previous loading operation if it exists
      _loadNodesOperation?.cancel();

      // Start a new loading operation
      _loadNodesOperation = CancelableOperation.fromFuture(
          // Call the usecase to load the nodes from api
          GetAllNodesUsecase()
              .call(params: GetAllNodesUsecaseParams(companyId: companyId)),
          // On cancel, return an empty map
          // Can be changed to a more specific error
          onCancel: () {
        return (null, {});
      });

      // Get the result of the loading operation, if it was canceled, return an empty map (can be changed to a more specific error)
      final (_, resultNodes) =
          await _loadNodesOperation?.valueOrCancellation() ??
              (null, <String, Node>{});

      // Add the result to the allNodes map
      allNodes.addAll(resultNodes ?? {});
    } catch (e) {
      // If an error occurs, clear the allNodes map
      allNodes.clear();
    }
  }

  Future<void> filterNodes(bool isEnergyFilterActive, bool isStatusFilterActive,
      String searchText, SendPort mainThreadInputPort) async {
    try {
      // If the nodes are already filtering, cancel the previous operation
      if (_isFiltering) {
        _filterNodesOperation?.cancel();
        _calculateVisibleNodesOperation?.cancel();
      }

      // Start a new filtering operation
      _filterNodesOperation = CancelableOperation.fromFuture(
          // Call the usecase to filter the nodes
          FilterTreeUsecase().call(
              params: FilterTreeUsecaseParams(
                  isEnergyFilterActive: isEnergyFilterActive,
                  isStatusFilterActive: isStatusFilterActive,
                  searchText: searchText,
                  fullTree: allNodes)));

      // Get the result of the filtering operation, if it was canceled, return an empty list (can be changed to a more specific error)
      final (_, resultNodes) =
          await _filterNodesOperation?.valueOrCancellation() ??
              (null, <Node>[]);

      // Calculate the visible nodes
      _calculateVisibleNodesOperation = CancelableOperation.fromFuture(
          CalculateVisibleItemsUsecase().call(
              params: CalculateVisibleItemsUsecaseParams(
                  isEnergyFilterActive: isEnergyFilterActive,
                  isStatusFilterActive: isStatusFilterActive,
                  searchText: searchText,
                  nodes: resultNodes ?? [])));

      final (_, visibleNodes) =
          await _calculateVisibleNodesOperation?.valueOrCancellation() ??
              (null, <String, bool>{});

      // Send the result to the main thread
      mainThreadInputPort.send(FilterNodesResult(
        isEnergyFilterActive: isEnergyFilterActive,
        isAlertFilterActive: isStatusFilterActive,
        searchText: searchText,
        nodes: resultNodes ?? [],
        visibleNodes: visibleNodes ?? {},
      ));
    } catch (e) {
      // If an error occurs, send an empty list to the main thread
      mainThreadInputPort.send(FilterNodesResult(
        isEnergyFilterActive: isEnergyFilterActive,
        isAlertFilterActive: isStatusFilterActive,
        searchText: searchText,
        nodes: [],
        visibleNodes: {},
      ));
    }
  }

  void dispose() {
    // Clear the allNodes map.
    allNodes.clear();

    // Cancel the loading and filtering operations.
    _loadNodesOperation?.cancel();
    _filterNodesOperation?.cancel();
  }
}
