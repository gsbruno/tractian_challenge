import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String asset;
  final String text;
  final double? width;
  final double? height;

  const SecondaryButton({
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
      icon: Image.asset(
        asset,
        height: 34,
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          text,
          style: appStyle.mainButtonTextStyle,
        ),
      ),
      style: appStyle.secondaryButtonStyle.copyWith(
        minimumSize: WidgetStatePropertyAll(
          Size(width ?? double.infinity, height ?? 60),
        ),
      ),
    );
  }
}