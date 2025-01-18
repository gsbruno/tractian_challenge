import 'package:tractian_challenge/core/utils/errors/commom_errors.dart'
    as utils;
import 'package:tractian_challenge/shared/presentation/state_managment/screen_data.dart';

sealed class ScreenState<T extends ScreenData> {
  const ScreenState(this._data);

  final T? _data;

  @override
  bool operator ==(Object other) =>
      other is ScreenState && other._data == _data;

  @override
  int get hashCode => _data.hashCode;
}

final class Loading<T extends ScreenData> extends ScreenState<T> {
  const Loading() : super(null);

  @override
  String toString() => 'Loading';
}

final class Error<T extends ScreenData> extends ScreenState<T> {
  Error(this.error) : super(null);

  final utils.CommomError error;

  @override
  String toString() => 'Error';
}

final class Ready<T extends ScreenData> extends ScreenState<T> {
  const Ready(super._data);

  T get data => _data as T;

  @override
  String toString() => 'Ready';
}
