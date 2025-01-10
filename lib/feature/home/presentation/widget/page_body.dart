import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:tractian_challenge/core/utils/constants/assets.dart';
import 'package:tractian_challenge/feature/home/presentation/state_managment/events/home_page_events.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_state.dart';
import 'package:tractian_challenge/shared/presentation/widget/primary_button.dart';

class PageBody extends StatefulWidget {
  const PageBody({super.key});

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> with HomePageEvents {
  @override
  Widget build(BuildContext context) {
    final state = store.state.watch(context);

    return state is Ready ? _readyScreen : _loadingWidget;
  }

  Widget get _loadingWidget => const Center(
        child: CircularProgressIndicator(),
      );

  Widget get _readyScreen => SuperListView.builder(
        padding: const EdgeInsets.all(34),
        itemCount: numberOfCompanies,
        itemBuilder: (context, index) {
          final currentCompany = company(index);

          return currentCompany != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 34),
                  child: PrimaryButton(
                    height: 200,
                    onPressed: () => goToCompanyPage(currentCompany.id),
                    asset: Assets.company,
                    text: currentCompany.name,
                  ),
                )
              : const SizedBox.shrink();
        },
      );
}

