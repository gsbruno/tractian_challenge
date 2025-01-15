import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';

AppStyles get appStyle => AppStyles();

final class AppStyles {
  TextStyle get mainButtonTextStyle => const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );

  TextStyle get secondaryButtonTextStyle => const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );

  TextStyle get searchBarTextStyle => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
        color: AppColors.onBackgroundColor,
      );

  TextStyle get listItemTextStyle => const TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      );

  ButtonStyle get primaryButtonStyle => ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.onBackgroundColor;
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.onSecondaryColor;
            }
            return AppColors.onPrimaryColor;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.backgroundColor;
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.secondaryColor;
            }
            return AppColors.primaryColor;
          },
        ),
        shape: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.onBackgroundColor),
              );
            }
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            );
          },
        ),
      );

  ButtonStyle get secondaryButtonStyle => ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.onSecondaryColor;
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.onBackgroundColor;
            }
            return AppColors.onBackgroundColor;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.secondaryColor;
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.backgroundColor;
            }
            return AppColors.backgroundColor;
          },
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.onBackgroundColor),
          ),
        ),
      );
}
