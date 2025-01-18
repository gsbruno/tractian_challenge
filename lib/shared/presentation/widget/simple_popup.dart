import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/styles/app_colors.dart';
import 'package:tractian_challenge/core/styles/app_styles.dart';

class SimplePopup extends StatelessWidget {
  const SimplePopup({required this.title, required this.content, super.key});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: appStyle.homeButtonTextStyle.copyWith(color: AppColors.black),
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: appStyle.homeButtonTextStyle.copyWith(color: AppColors.black),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: appStyle.homeButtonStyle,
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static Future<Null> show(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimplePopup(
          title: title,
          content: content,
        );
      },
    );
  }
}
