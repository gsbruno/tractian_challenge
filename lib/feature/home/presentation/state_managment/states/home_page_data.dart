import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/feature/home/data/models/company_model.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_data.dart';

final class HomePageData extends ScreenData<HomePageData>
    with EquatableMixin {
  const HomePageData._({
    required this.companies,
  });

  factory HomePageData.init() => const HomePageData._(
        companies: [],
      );

  const HomePageData.set({
    this.companies = const [],
  });

  final List<CompanyModel> companies;

  @override
  HomePageData changeWith({
    List<CompanyModel>? companies,
  }) {
    return HomePageData.set(
      companies: companies ?? this.companies,
    );
  }

  @override
  List<Object?> get props => [
        companies,
      ];
}
