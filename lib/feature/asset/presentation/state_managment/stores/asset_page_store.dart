import 'package:tractian_challenge/feature/asset/domain/usecases/filter_tree_usecase.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/get_all_nodes_usecase.dart';
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

  Future<void> loadData() async {
    newState(const screen_state.Loading());

    final result = await GetAllNodesUsecase().call(params: GetAllNodesUsecaseParams(companyId: companyId));

    switch (result) {   
      case (final error?, _):
        newState(screen_state.Error(error));
        break;
      case (_, final nodes?):
        final (_, tree) = await FilterTreeUsecase().call(params: FilterTreeUsecaseParams(
          isEnergyFilterActive: false,
          isStatusFilterActive: false,
          searchText: '',
          tree: nodes,
        ));
        final newPageData = AssetPageData.set(allNodes: nodes, tree: tree ?? {});

        newState(screen_state.Ready(newPageData));
        break;
    }
  }

  Future<void> filterByEnergy(bool isEnergyFilterActive) async {
    newState(const screen_state.Loading());

    final (_, filteredTree) = await FilterTreeUsecase().call(params: FilterTreeUsecaseParams(
      isEnergyFilterActive: isEnergyFilterActive,
      isStatusFilterActive: data?.isStatusFilterActive ?? false,
      searchText: data?.searchText ?? '',
      tree: data?.allNodes ?? {},
    ));

    final newPageData = data!.changeWith(
      isEnergyFilterActive: isEnergyFilterActive,
      tree: filteredTree ?? {},
    );

    newState(screen_state.Ready(newPageData));
  }

  Future<void> filterByStatus(bool isStatusFilterActive) async {
    newState(const screen_state.Loading());

    final (_, filteredTree) = await FilterTreeUsecase().call(params: FilterTreeUsecaseParams(
      isEnergyFilterActive: data?.isEnergyFilterActive ?? false,
      isStatusFilterActive: isStatusFilterActive,
      searchText: data?.searchText ?? '',
      tree: data?.allNodes ?? {},
    ));

    final newPageData = data!.changeWith(
      isStatusFilterActive: isStatusFilterActive,
      tree: filteredTree ?? {},
    );

    newState(screen_state.Ready(newPageData));
  }

  Future<void> filterByText(String searchText) async {
    newState(const screen_state.Loading());

    final (_, filteredTree) = await FilterTreeUsecase().call(params: FilterTreeUsecaseParams(
      isEnergyFilterActive: data?.isEnergyFilterActive ?? false,
      isStatusFilterActive: data?.isStatusFilterActive ?? false,
      searchText: searchText,
      tree: data?.allNodes ?? {},
    ));

    final newPageData = data!.changeWith(
      searchText: searchText,
      tree: filteredTree ?? {},
    );

    newState(screen_state.Ready(newPageData));
  }
}


