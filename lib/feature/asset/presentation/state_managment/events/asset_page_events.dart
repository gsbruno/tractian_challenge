import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/asset_page_store.dart';

mixin AssetPageEvents<T extends StatefulWidget> on State<T> {
  late final AssetPageStore store;

  late final String companyId;

  final effects = <EffectCleanup>[];

  @override
  void initState() {
    super.initState();
    store = AssetPageStore.init(companyId: companyId);

    _initEffects();

    store.loadData();
  }

  void _initEffects() async {
    effects
        .add(store.popUpErrorEffect(context));
  }

  bool get isEnergyFilterActive => store.data?.isEnergyFilterActive ?? false;

  bool get isCriticalFilterActive => store.data?.isStatusFilterActive ?? false;

  String get energyFilterText => store.data?.searchText ?? '';

  void changeEnergyFilter() {
    store.filterByEnergy(!(store.data?.isEnergyFilterActive ?? true));
  }

  void changeStatusFilter() {
    store.filterByStatus(!(store.data?.isStatusFilterActive ?? true));
  }

  void changeTextFilter(String searchText) {
    store.filterByText(searchText);
  }

  void _disposeEffects() {
    for (var effect in effects) {
      effect();
    }

    effects.clear();
  }

  @override
  void dispose() {
    _disposeEffects();
    super.dispose();
  }
}
