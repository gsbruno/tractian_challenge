import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:tractian_challenge/core/utils/constants/assets.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/events/asset_page_events.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/asset_app_bar.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/search_bar.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/tree_list.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_state.dart';
import 'package:tractian_challenge/shared/presentation/widget/primary_button.dart';
import 'package:tractian_challenge/shared/presentation/widget/secondary_button.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key, required this.companyId});

  final String companyId;

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> with AssetPageEvents {
  @override
  void initState() {
    companyId = widget.companyId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = store.state.watch(context);

    return Scaffold(
      appBar: const AssetAppBar(),
      body: state is Ready ? _readyWidget : _loadingWidget,
    );
  }

  Widget get _loadingWidget => const Center(
        child: CircularProgressIndicator(),
      );

  Widget get _readyWidget => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16),
          AssetSearchBar(onChanged: changeTextFilter),
          const SizedBox(height: 16),
          _filter(changeEnergyFilter, changeStatusFilter),
          Expanded(child: Padding(
              padding: const EdgeInsets.all(16), 
              child: TreeList(tree: store.data?.roots ?? {}),
            ),
          ),
        ],
      );

  Widget _filter(VoidCallback energyFilter, VoidCallback criticalFilter) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _energyFilter(energyFilter),
          const SizedBox(width: 16),
          _criticalFilter(criticalFilter),
          ],  
        ),
      );

  Widget _energyFilter(VoidCallback energyFilter) => isEnergyFilterActive ? PrimaryButton(
              height: 60,
              width: 120,
              asset: Assets.energyWhite,
              text: 'Sensor de Energia',
            onPressed: energyFilter,
          ) : SecondaryButton(
            height: 60,
            width: 120,
            asset: Assets.energyGrey,
            text: 'Sensor de Energia',
            onPressed: energyFilter,
          );

  Widget _criticalFilter(VoidCallback criticalFilter) => isCriticalFilterActive ? PrimaryButton(
              height: 60,
              width: 120,
              asset: Assets.criticalWhite,
              text: 'Crítico',
            onPressed: criticalFilter,
          ) : SecondaryButton(
            height: 60,
            width: 120,
            asset: Assets.criticalGrey,
            text: 'Crítico',
            onPressed: criticalFilter,
          );
}
