import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String text;
  final TextStyle? textStyle;
  final ButtonStyle? style;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.textStyle,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ?? appStyle.homeButtonTextStyle;

    return TextButton.icon(
      onPressed: onPressed,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          icon,
          color: textStyle.color,
          size: textStyle.fontSize,
        ),
      ),
      label: Text(
        text,
        style: textStyle,
      ),
      style: style,
    );
  }
}
