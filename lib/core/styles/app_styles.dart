import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';

AppStyles get appStyle => AppStyles();

final class AppStyles {
  TextStyle get homeButtonTextStyle => const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        color: AppColors.white,
      );

  TextStyle get titleTextStyle => const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        color: AppColors.white,
      );

  TextStyle get assetButtonTextStyle => const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );

  TextStyle get searchBarTextStyle => const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        color: AppColors.grey3,
      );

  TextStyle get listItemTextStyle => const TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      );

  ButtonStyle get homeButtonStyle => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.blue.withOpacity(0.8);
            }
            return AppColors.blue;
          },
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(
          Size(100, 100),
        ),
        alignment: Alignment.centerLeft,
      );

  ButtonStyle get assetButtonStyle => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.grey1;
            }
            return AppColors.white;
          },
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: AppColors.grey2,
              width: 3,
            ),
          ),
        ),
      );
}
