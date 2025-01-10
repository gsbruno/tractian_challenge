class DataStack<T> {
  DataStack.withDepth(int? depth)
      : _depth = switch (depth) {
          (int d) when d > 0 => d,
          _ => 100,
        };

  final int _depth;

  final List<T> _stack = [];

  void push(T element) {
    if (_stack.length >= _depth) {
      _stack.removeAt(0);
    }

    _stack.add(element);
  }

  T? get pop => _stack.isNotEmpty ? _stack.removeLast() : null;

  T? get top => _stack.isNotEmpty ? _stack.last : null;

  bool get isEmpty => _stack.isEmpty;

  bool get isNotEmpty => _stack.isNotEmpty;
}
