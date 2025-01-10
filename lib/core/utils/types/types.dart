import 'package:tractian_challenge/core/utils/errors/commom_errors.dart';

typedef QueryParameters = Map<String, dynamic>?;

typedef Json = Map<String, dynamic>;

typedef Output<T> = Future<(CommomError?, T?)>;
