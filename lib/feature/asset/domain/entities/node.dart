base class Node {
  Node({required this.id, required this.name, this.parentId, Map<String, Node>? children}) : children = children ?? {};

  final String id;
  final String name;
  final String? parentId;

  final Map<String, Node> children;

  void addChild(Node child) {
    children[child.id] = child;
  }

  void clearChildren() {
    children.clear();
  }

  bool get isRoot => parentId == null;

  bool get isLeaf => children.isEmpty;

  String get asset => '';
}
