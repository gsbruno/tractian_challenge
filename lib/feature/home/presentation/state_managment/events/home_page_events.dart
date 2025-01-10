import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:tractian_challenge/feature/asset/presentation/pages/asset_page.dart';
import 'package:tractian_challenge/feature/home/data/models/company_model.dart';
import 'package:tractian_challenge/feature/home/presentation/state_managment/stores/home_page_store.dart';

mixin HomePageEvents<T extends StatefulWidget> on State<T> {
  late final HomePageStore store;

  final effects = <EffectCleanup>[];

  @override
  void initState() {
    super.initState();
    store = HomePageStore.init();

    _initEffects();

    store.loadData();
  }

  void _initEffects() async {
    effects
        .add(store.popUpErrorEffect(context));
  }

  int get numberOfCompanies => store.data?.companies.length ?? 0;

  CompanyModel? company(int index) => store.data?.companies[index];

  void goToCompanyPage(String companyId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AssetPage(companyId: companyId),
      ),
    );
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
