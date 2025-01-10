import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/core/utils/constants/assets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      title: Image.asset(Assets.logo, height: preferredSize.height * 0.6),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
