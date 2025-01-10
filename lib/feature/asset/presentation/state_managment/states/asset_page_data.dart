import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_data.dart';

final class AssetPageData extends ScreenData<AssetPageData>
    with EquatableMixin {
  const AssetPageData._({
    required this.allNodes,
    required this.tree,
    this.isEnergyFilterActive = false,
    this.isStatusFilterActive = false,
    this.searchText = '',
  });

  factory AssetPageData.init() => const AssetPageData._(
        allNodes: {},
        tree: {},
        isEnergyFilterActive: false,
        isStatusFilterActive: false,
        searchText: '',
      );

  const AssetPageData.set({
    this.allNodes = const {},
    this.tree = const {},
    this.isEnergyFilterActive = false,
    this.isStatusFilterActive = false,
    this.searchText = '',
  });

  final Map<String, Node> allNodes;

  final Map<String, Node> tree;

  Map<String, Node> get roots => Map.fromIterable(tree.values.where((node) => node.isRoot), key: (node) => node.id, value: (node) => node);

  final bool isEnergyFilterActive;

  final bool isStatusFilterActive;

  final String searchText;

  @override
  AssetPageData changeWith({
    Map<String, Node>? allNodes,
    Map<String, Node>? tree,
    bool? isEnergyFilterActive,
    bool? isStatusFilterActive,
    String? searchText,
  }) {
    return AssetPageData.set(
      allNodes: allNodes ?? this.allNodes,
      tree: tree ?? this.tree,
      isEnergyFilterActive: isEnergyFilterActive ?? this.isEnergyFilterActive,
      isStatusFilterActive: isStatusFilterActive ?? this.isStatusFilterActive,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
        allNodes,
        tree,
        isEnergyFilterActive,
        isStatusFilterActive,
        searchText,
      ];
}
