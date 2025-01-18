import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';
import 'package:tractian_challenge/core/utils/constants/tractian_icons_icons.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/asset_page_store.dart';
import 'package:tractian_challenge/shared/presentation/widget/primary_button.dart';

class FilterSelector extends StatefulWidget {
  const FilterSelector({super.key});

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  late final AssetPageStore store;
  bool isEnergyFilterSelected = false;
  bool isCriticalFilterSelected = false;

  @override
  void initState() {
    super.initState();
    store = GetIt.I.get<AssetPageStore>();
  }

  void _toggleEnergyFilter() {
    setState(() {
      isEnergyFilterSelected = !isEnergyFilterSelected;
    });
    store.setEnergyFilter(isEnergyFilterSelected);
  }

  void _toggleCriticalFilter() {
    setState(() {
      isCriticalFilterSelected = !isCriticalFilterSelected;
    });
    store.setAlertFilter(isCriticalFilterSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _energyFilter,
          const SizedBox(width: 16),
          _criticalFilter,
        ],
      ),
    );
  }

  Widget get _energyFilter => isEnergyFilterSelected
      ? PrimaryButton(
          icon: TractianIcons.energy,
          text: 'Sensor de Energia',
          onPressed: _toggleEnergyFilter,
          style: _activeButtonStyle,
          textStyle: _activeTextStyle,
        )
      : PrimaryButton(
          icon: TractianIcons.energy,
          text: 'Sensor de Energia',
          onPressed: _toggleEnergyFilter,
          style: _inactiveButtonStyle,
          textStyle: _inactiveTextStyle,
        );

  Widget get _criticalFilter => isCriticalFilterSelected
      ? PrimaryButton(
          icon: TractianIcons.alert,
          text: 'Crítico',
          onPressed: _toggleCriticalFilter,
          style: _activeButtonStyle,
          textStyle: _activeTextStyle,
        )
      : PrimaryButton(
          icon: TractianIcons.alert,
          text: 'Crítico',
          onPressed: _toggleCriticalFilter,
          style: _inactiveButtonStyle,
          textStyle: _inactiveTextStyle,
        );

  TextStyle get _activeTextStyle => appStyle.assetButtonTextStyle.copyWith(
        color: AppColors.white,
      );

  TextStyle get _inactiveTextStyle => appStyle.assetButtonTextStyle.copyWith(
        color: AppColors.grey4,
      );

  ButtonStyle get _activeButtonStyle =>
      appStyle.homeButtonStyle.copyWith(minimumSize: _minimumSize);

  ButtonStyle get _inactiveButtonStyle => appStyle.assetButtonStyle.copyWith(
        minimumSize: _minimumSize,
      );

  WidgetStatePropertyAll<Size> get _minimumSize =>
      const WidgetStatePropertyAll(Size(100, 60));
}
