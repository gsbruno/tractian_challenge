import 'package:flutter/material.dart';
import 'package:tractian_challenge/feature/home/presentation/widget/main_app_bar.dart';
import 'package:tractian_challenge/feature/home/presentation/widget/page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: PageBody(),
    );
  }
}