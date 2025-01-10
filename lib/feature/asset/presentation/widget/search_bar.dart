import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';

class AssetSearchBar extends StatelessWidget {
  const AssetSearchBar({
    super.key,
    required this.onChanged,
  });

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: onChanged,
        style: appStyle.searchBarTextStyle,
        decoration: InputDecoration(
          hintText: 'Buscar Ativo ou Local',
          hintStyle: appStyle.searchBarTextStyle,
          prefixIcon: const Icon(Icons.search, color: AppColors.onBackgroundColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.onBackgroundColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.onBackgroundColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
