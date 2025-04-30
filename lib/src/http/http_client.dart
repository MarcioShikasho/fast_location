import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio = Dio();
  
  Dio get client => _dio;
  
  HttpClient() {
    _dio.options.baseUrl = 'https://viacep.com.br/ws';
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
  }
}