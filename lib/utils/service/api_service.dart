import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<Response> get(url,
      {queryParam,
      page,
      withToken = true,
      required String accessToken,
      required String apiKey}) async {
    _dio.interceptors.add(LoggingInterceptor());
    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = apiKey;

    log(url.toString());
    log(accessToken.toString());
    log(apiKey.toString());

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);

      return response;
    } on DioException catch (error) {
      log(error.toString());

      if (error.response!.statusCode == 401) {}
      return error.response!.data;
    }
  }

  Future<Response> post(url, body,
      {bool withToken = true,
      bool formData = false,
      required String accessToken,
      required String apiKey,
      parameter}) async {
    _dio.interceptors.add(LoggingInterceptor());

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = apiKey;
    log(url.toString());
    log(accessToken.toString());
    log(apiKey.toString());
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.post(url,
          data: formData ? formBody : body, queryParameters: parameter);

      return response;
    } on DioException catch (error) {
      log(error.toString());
      return error.response!;
    }
  }

  Future<Response> put(url, body,
      {bool withToken = true,
      bool formData = false,
      required String accessToken,
      required String apiKey}) async {
    _dio.interceptors.add(LoggingInterceptor());

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = apiKey;

    log(url.toString());
    log(accessToken.toString());
    log(apiKey.toString());
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.put(
        url,
        data: formData ? formBody : body,
      );

      return response;
    } on DioException catch (error) {
      log(error.toString());
      return error.response!;
    }
  }

  Future<Response> delete(url,
      {bool withToken = true,
      required String accessToken,
      required String apiKey}) async {
    _dio.interceptors.add(LoggingInterceptor());
    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      _dio.options.headers['Accept'] = 'application/json';
    }
    _dio.options.headers['ApiKey'] = apiKey;

    log(url.toString());
    log(accessToken.toString());
    log(apiKey.toString());
    Response response = await _dio.delete(url);
    return response;
  }
}

class LoggingInterceptor extends InterceptorsWrapper {
  int _maxCharactersPerLine = 200;
}
