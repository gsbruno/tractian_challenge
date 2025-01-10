import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tractian_challenge/core/network/server_urls.dart';
import 'package:tractian_challenge/core/utils/errors/commom_errors.dart';
import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/shared/data/dio_response.dart';
import 'package:tractian_challenge/shared/data/model.dart';

abstract base class RemoteDataSource<T extends Model> {
  RemoteDataSource({Dio? dio}) : dio = dio ?? Dio() {
    this.dio.options.baseUrl = ServerUrls.base.url;
    handleRequest();
    handleResponse();
    handleError();
  }
  final Dio dio;

  ServerUrls get serverUrl;

  @mustCallSuper
  @protected
  void handleRequest() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
      ),
    );
  }

  @mustCallSuper
  @protected
  void handleResponse() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );
  }

  @mustCallSuper
  @protected
  void handleError() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Output<List<T>> getAllById({required String id}) async => (UnimplementedError(), null);

  @protected
  Future<List> callGetAllById({required String id}) async {
    try {
      return await dio
          .get<List>(serverUrl.idUrl(id))
          .solve();
    } catch (e) {
      rethrow;
    }
  }

  Output<List<T>> getAll() async => (UnimplementedError(), null);

  @protected
  Future<List> callGetAll() async {
    try {
      return await dio
          .get<List>(serverUrl.path)
          .solve();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> close() async {
    dio.close();
  }

  @protected
  (CommomError, Null) errorTreatment(Object e) {
    if (e is CommomError) {
      return (e, null);
    }
    return (UnexpectedLocalError(message: e.toString()), null);
  }
}
