import 'package:flutter/material.dart';

import 'package:signals/signals_flutter.dart';
import 'package:tractian_challenge/core/utils/data_stack.dart';

import 'package:tractian_challenge/core/utils/errors/commom_errors.dart'
    as utils;
import 'package:tractian_challenge/shared/presentation/state_managment/screen_data.dart';
import 'package:tractian_challenge/shared/presentation/state_managment/screen_state.dart';
import 'package:tractian_challenge/shared/presentation/widget/simple_popup.dart';

class Store<T extends ScreenData<T>> {
  Store({required ScreenState<T> initialState, int depth = 1})
      : _previousData = DataStack<T>.withDepth(depth) {
    state = signal(initialState, debugLabel: '$runtimeType');
  }

  factory Store.init(
          {ScreenState<T> initialState = const Loading(), int depth = 1}) =>
      Store(initialState: initialState, depth: depth);

  late final Signal<ScreenState<T>> state;

  final DataStack<T> _previousData;

  T? get data {
    if (state.peek() case Ready(:T data)) {
      return data;
    }

    return _previousData.top;
  }

  void newState(ScreenState<T> state) {
    // If the state is the same, do nothing
    if (this.state.peek() == state) {
      return;
    }

    if (data case final data? when data != _previousData.top) {
      _previousData.push(data);
    }

    this.state.value = state;
  }

  EffectCleanup popUpErrorEffect(BuildContext context) {
    return effect(() {
      if (state.value case Error(:final error)) {
        SimplePopup.show(context, title: 'Error', content: error.message).then(
          (_) => treatError(error),
        );
      }
    });
  }

  void treatError(utils.CommomError error) {
    newState(Ready(data));
  }
}
