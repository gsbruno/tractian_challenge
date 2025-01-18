import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/asset_page_store.dart';

mixin AssetPageEvents<T extends StatefulWidget> on State<T> {
  late final AssetPageStore store;

  late final String companyId;

  final effects = <EffectCleanup>[];

  @override
  void initState() {
    super.initState();
    store = GetIt.I.registerSingletonIfAbsent<AssetPageStore>(
        () => AssetPageStore.init(companyId: companyId));

    _initEffects();

    store.loadData();
  }

  void _initEffects() async {
    effects.add(store.popUpErrorEffect(context));
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
    store.loadWorker.dispose();
    GetIt.I.unregister<AssetPageStore>();
    super.dispose();
  }
}
