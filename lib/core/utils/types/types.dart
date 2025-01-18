import 'package:tractian_challenge/core/utils/errors/commom_errors.dart';

typedef QueryParameters = Map<String, dynamic>?;

typedef Json = Map<String, dynamic>;

typedef FutureOutput<T> = Future<(CommomError?, T?)>;

typedef Output<T> = (CommomError?, T?);
