import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_data.dart';

final class AssetPageData extends ScreenData<AssetPageData>
    with EquatableMixin {
  const AssetPageData._({
    required this.tree,
    this.visibleNodes = const {},
    this.isEnergyFilterActive = false,
    this.isStatusFilterActive = false,
    this.searchText = '',
  });

  factory AssetPageData.init() => const AssetPageData._(
        tree: [],
        visibleNodes: {},
        isEnergyFilterActive: false,
        isStatusFilterActive: false,
        searchText: '',
      );

  const AssetPageData.set({
    this.tree = const [],
    this.visibleNodes = const {},
    this.isEnergyFilterActive = false,
    this.isStatusFilterActive = false,
    this.searchText = '',
  });

  final List<Node> tree;

  final Map<String, bool> visibleNodes;

  final bool isEnergyFilterActive;

  final bool isStatusFilterActive;

  final String searchText;

  @override
  AssetPageData changeWith({
    List<Node>? tree,
    Map<String, bool>? visibleNodes,
    bool? isEnergyFilterActive,
    bool? isStatusFilterActive,
    String? searchText,
  }) {
    return AssetPageData.set(
      tree: tree ?? this.tree,
      visibleNodes: visibleNodes ?? this.visibleNodes,
      isEnergyFilterActive: isEnergyFilterActive ?? this.isEnergyFilterActive,
      isStatusFilterActive: isStatusFilterActive ?? this.isStatusFilterActive,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
        tree,
        visibleNodes,
        isEnergyFilterActive,
        isStatusFilterActive,
        searchText,
      ];
}
