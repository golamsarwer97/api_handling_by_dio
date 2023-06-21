import 'package:dio/dio.dart';

class HttpService {
  Dio? _dio;

  final baseUrl = "https://reqres.in/";

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
  }
}
