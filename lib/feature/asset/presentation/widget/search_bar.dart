import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';
import 'package:tractian_challenge/core/utils/constants/tractian_icons_icons.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/asset_page_store.dart';

class AssetSearchBar extends StatefulWidget {
  const AssetSearchBar({super.key});

  @override
  State<AssetSearchBar> createState() => _AssetSearchBarState();
}

class _AssetSearchBarState extends State<AssetSearchBar> {
  late final AssetPageStore store;

  @override
  void initState() {
    super.initState();
    store = GetIt.I.get<AssetPageStore>();
  }

  String onChanged(String value) {
    store.setSearchText(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: onChanged,
        style: appStyle.searchBarTextStyle,
        decoration: InputDecoration(
          hintText: 'Buscar Ativo ou Local',
          hintStyle: appStyle.searchBarTextStyle,
          prefixIcon: const Icon(TractianIcons.search, color: AppColors.grey3),
          filled: true,
          fillColor: AppColors.grey1,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
