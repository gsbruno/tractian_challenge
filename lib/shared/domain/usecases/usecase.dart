import 'package:tractian_challenge/core/utils/types/types.dart';

abstract class UseCase<T, P extends Params> {
  UseCase();

  FutureOutput<T> call({P? params});
}

base class Params {
  Params();
}
