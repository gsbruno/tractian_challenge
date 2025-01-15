import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String asset;
  final String text;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.asset,
    required this.text,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Image.asset(
          asset,
          height: 21,
        ),
      ),
      label: Text(
        text,
        style: appStyle.secondaryButtonTextStyle,
      ),
      style: appStyle.primaryButtonStyle.copyWith(
          minimumSize: WidgetStatePropertyAll(
            Size(width ?? double.infinity, height ?? 60),
          ),
          alignment: Alignment.centerLeft),
    );
  }
}
