import 'package:tractian_challenge/feature/home/domain/usecases/get_all_companies_usecase.dart';
import 'package:tractian_challenge/feature/home/presentation/state_managment/states/home_page_data.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_state.dart'
    as screen_state;
import 'package:tractian_challenge/shared/presentation/state_managment/store.dart';

class HomePageStore extends Store<HomePageData> {
  HomePageStore()
      : super(initialState: const screen_state.Loading());

  HomePageStore.init()
      : super(initialState: const screen_state.Loading());

  Future<void> loadData() async {
    newState(const screen_state.Loading());

    final result = await GetAllCompaniesUsecase().call();

    switch (result) {   
      case (final error?, _):
        newState(screen_state.Error(error));
      case (_, final companies?):
        final newPageData = HomePageData.set(companies: companies);

        newState(screen_state.Ready(newPageData));
    }
  }
}

