import 'package:flutter/foundation.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/threading/load_worker.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/states/asset_page_data.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_state.dart'
    as screen_state;
import 'package:tractian_challenge/shared/presentation/state_managment/store.dart';

class AssetPageStore extends Store<AssetPageData> {
  AssetPageStore({required this.companyId})
      : super(initialState: const screen_state.Loading());

  AssetPageStore.init({required this.companyId})
      : super(initialState: const screen_state.Loading());

  final String companyId;

  late final LoadWorker loadWorker;

  Future<void> loadData() async {
    newState(const screen_state.Loading());

    loadWorker = LoadWorker(
      companyId: companyId,
      onFilterNodesResult: (isEnergyFilterActive, isAlertFilterActive,
          searchText, nodes, visibleNodes) {
        final newPageData = AssetPageData.set(
          isEnergyFilterActive: isEnergyFilterActive,
          isStatusFilterActive: isAlertFilterActive,
          searchText: searchText,
          tree: nodes,
          visibleNodes: visibleNodes,
        );

        newState(screen_state.Ready(newPageData));
      },
    );
  }

  Future<void> setEnergyFilter(bool isEnergyFilterActive) async {
    newState(const screen_state.Loading());

    final newPageData = data!.changeWith(
      isEnergyFilterActive: isEnergyFilterActive,
    );

    loadWorker.filterNodes(
      newPageData.isEnergyFilterActive,
      newPageData.isStatusFilterActive,
      newPageData.searchText,
    );
  }

  Future<void> setAlertFilter(bool isAlertFilterActive) async {
    newState(const screen_state.Loading());

    final newPageData = data!.changeWith(
      isStatusFilterActive: isAlertFilterActive,
    );

    loadWorker.filterNodes(
      newPageData.isEnergyFilterActive,
      newPageData.isStatusFilterActive,
      newPageData.searchText,
    );
  }

  Future<void> setSearchText(String searchText) async {
    newState(const screen_state.Loading());

    final newPageData = data!.changeWith(
      searchText: searchText,
    );

    loadWorker.filterNodes(
      newPageData.isEnergyFilterActive,
      newPageData.isStatusFilterActive,
      newPageData.searchText,
    );
  }

  Future<List<String>> visibleNodes(Node node) async {
    return await compute(
      _visibleNodes,
      (
        data!.isEnergyFilterActive,
        data!.isStatusFilterActive,
        data!.searchText,
        node,
      ),
    );
  }

  static List<String> _visibleNodes((bool, bool, String, Node) message) {
    final (isEnergyFilterActive, isAlertFilterActive, searchText, node) =
        message;

    if (!isEnergyFilterActive && !isAlertFilterActive && searchText.isEmpty) {
      return node.children.map((child) => child.id).toList();
    }

    return node.children
        .where((child) =>
            (isEnergyFilterActive && child.hasEnergy) ||
            (isAlertFilterActive && child.hasAlert) ||
            (searchText.isNotEmpty && child.hasText(searchText)))
        .map((child) => child.id)
        .toList();
  }
}
