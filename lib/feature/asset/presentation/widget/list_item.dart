import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/presentation/state_managment/stores/asset_page_store.dart';
import 'package:tractian_challenge/feature/asset/presentation/widget/node_list.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  late final AssetPageStore store;

  late final List<Node> nodes;
  late final Map<String, bool> visibleNodes;

  @override
  void initState() {
    super.initState();
    store = GetIt.I.get<AssetPageStore>();

    nodes = store.data!.tree;

    visibleNodes = store.data!.visibleNodes;
  }

  void _toggleCollapsed(Node node) {
    if (_isOpen(node)) {
      _closeNode(node).then((_) => setState(() {}));
    } else {
      _openNode(node).then((_) => setState(() {}));
    }
  }

  bool _isOpen(Node node) {
    return visibleNodes[node.id] ?? false;
  }

  bool _isVisible(Node node) {
    return visibleNodes.containsKey(node.id);
  }

  Future<bool> _openNode(Node node) async {
    visibleNodes[node.id] = true;

    final children = await store.visibleNodes(node);

    for (var child in children) {
      visibleNodes[child] = false;
    }

    return true;
  }

  Future<bool> _closeNode(Node node) async {
    for (var child in node.flat) {
      visibleNodes.remove(child.id);
    }
    visibleNodes[node.id] = false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SuperListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) => _isVisible(nodes[index])
          ? NodeListItem(
              node: nodes[index],
              height: 40,
              isOpen: _isOpen(nodes[index]),
              onTap: _toggleCollapsed,
            )
          : const SizedBox.shrink(),
    );
  }
}
