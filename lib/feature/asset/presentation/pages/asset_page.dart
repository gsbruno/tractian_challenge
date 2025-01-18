import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/events/asset_page_events.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/asset_app_bar.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/filter_selector.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/list_item.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/search_bar.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_state.dart';

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
    return Scaffold(
      appBar: const AssetAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16),
          const AssetSearchBar(),
          const SizedBox(height: 16),
          const FilterSelector(),
          const SizedBox(height: 16),
          const Divider(
            color: AppColors.grey2,
            thickness: 1,
          ),
          Watch.builder(builder: (context) {
            final state = store.state.value;
            return Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: state is Ready ? _readyWidget : _loadingWidget),
            );
          })
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget get _loadingWidget => const Center(
        child: CircularProgressIndicator(),
      );

  Widget get _readyWidget => ListItem(
        key: ValueKey(store.data!.visibleNodes.hashCode),
      );
}
