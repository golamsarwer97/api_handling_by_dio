// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class HttpService {
  Dio? _dio;

  final baseUrl = "https://reqres.in/";

  HttpService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    initializerInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio!.get(endPoint);
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initializerInterceptors() {
    _dio?.interceptors.add(
      InterceptorsWrapper(
        onError: (dio, error) {
          print(error.toString());
          print(dio.error);
        },
        onRequest: (dio, request) {
          print('${dio.method} ${dio.path}');
        },
        onResponse: (dio, response) {
          print(dio.data);
        },
      ),
    );
  }
}
