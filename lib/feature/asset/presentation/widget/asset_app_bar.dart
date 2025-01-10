import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';

class AssetAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AssetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: AppColors.onSecondaryColor,
      title: Text(
        'Assets',
        style: appStyle.mainButtonTextStyle.copyWith(color: AppColors.onSecondaryColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
