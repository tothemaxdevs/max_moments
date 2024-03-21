import 'dart:async';
import 'dart:developer';
import 'package:max_moments/utils/environment/environment.dart';
import 'package:max_moments/utils/state/error_state.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> getNew(url, {queryParam, page, withToken = true}) async {
    log('--- GET NEW');
    log('--- URL : $url');
    _dio.interceptors.add(LoggingInterceptor());
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMDc0Njg1Mn0.VeN2gOhwV2xtXb3u03_skZmKEHROCcO6lpHEEfpvnW4';

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      _dio.options.headers['Accept'] = 'application/json';
    }
    _dio.options.headers['ApiKey'] = Environment.apikey;
    log('QUERY $queryParam');
    log('Url: $url');

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      log('RESPONSE $response');
      return response;
    } on DioException catch (error) {
      log('===ERROR ${error.toString()}');
      log('ERROR ${error.stackTrace.toString()}');
      return error.response!.data;
    }
  }

  Future<Response> get(url, {queryParam, page, withToken = true}) async {
    log('--- GET');
    log('--- PARAM : ${queryParam.toString()}');
    log('--- URL : $url');
    _dio.interceptors.add(LoggingInterceptor());
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMDc0Njg1Mn0.VeN2gOhwV2xtXb3u03_skZmKEHROCcO6lpHEEfpvnW4';
    log('--- GET : $accessToken');
    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = Environment.apikey;

    try {
      Response response = await _dio.get(url, queryParameters: queryParam);
      log('RESPONSE ${response.data}');
      return response;
    } on DioException catch (error) {
      log('---------------------');
      log('ERROR DISINI GAES');
      log(url.toString());
      log(error.message.toString());
      log(error.response!.statusCode.toString());
      log('---------------------');

      if (error.response!.statusCode == 401) {
        log('Error 401 di URL $url');
        // SEMENTARA
        // GlobalNavigator.showAlertDialog('Any message', onClick: () {
        //   LocalStorageService.removeValues();
        //   // _googleSignIn.disconnect();
        //   Navigator.pushNamedAndRemoveUntil(
        //       navigatorKey.currentContext!, LoginScreen.path, (route) => false);
        // });
      }
      return error.response!.data;
    }
  }

  Future<Response> getMap(url, {query}) async {
    try {
      query['key'] = 'AIzaSyCbo7jjDTdFANGzFcWCc9MwXsmID-OXgiQ';
      log(query);
      Response response = await _dio.get(url, queryParameters: query);
      log(response.toString());
      return response;
    } on DioException catch (error) {
      log('ERROR ${error.stackTrace.toString()}');
      return error.response!.data;
    }
  }

  Future<Response> post(url, body,
      {bool withToken = true,
      bool formData = false,
      bool formUrlencoded = false,
      parameter}) async {
    log('--- POST');
    log('--- ${body.toString()}');
    log('--- URL : $url');
    log('--- PARAMS : $parameter');
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMDc0Njg1Mn0.VeN2gOhwV2xtXb3u03_skZmKEHROCcO6lpHEEfpvnW4';
    _dio.interceptors.add(LoggingInterceptor());

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      // log('BEARER $accessToken');
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = Environment.apikey;
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.post(url,
          data: formData ? formBody : body,
          queryParameters: parameter,
          options: Options(
              contentType:
                  formUrlencoded ? 'application/x-www-form-urlencoded' : null));
      log('RESPONSE ${response.data}');
      return response;
    } on DioException catch (error) {
      log('ERROR ${handleErrorDio(error).toString()}');
      log('ERROR ${error.response}');
      return error.response!;
    }
  }

  Future<Response> put(url, body,
      {bool withToken = true,
      bool formData = false,
      bool formUrlencoded = false}) async {
    log('--- PUT');
    log('--- ${body.toString()}');
    log('--- URL : $url');
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMDc0Njg1Mn0.VeN2gOhwV2xtXb3u03_skZmKEHROCcO6lpHEEfpvnW4';
    _dio.interceptors.add(LoggingInterceptor());

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      // log('BEARER $accessToken');
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = Environment.apikey;
    var formBody = FormData.fromMap(body);

    try {
      Response response = await _dio.put(url,
          data: formData ? formBody : body,
          options: Options(
              contentType:
                  formUrlencoded ? 'application/x-www-form-urlencoded' : null));
      log('RESPONSE ${response.data}');
      return response;
    } on DioException catch (error) {
      log('ERROR ${handleErrorDio(error).toString()}');
      log('ERROR ${error.response}');
      log('ERROR $error');
      return error.response!;
    }
  }

  Future<Response> delete(url, {bool withToken = true}) async {
    log('--- DELETE');
    log('--- URL : $url');
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMDc0Njg1Mn0.VeN2gOhwV2xtXb3u03_skZmKEHROCcO6lpHEEfpvnW4';
    _dio.interceptors.add(LoggingInterceptor());
    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      _dio.options.headers['Accept'] = 'application/json';
    }
    _dio.options.headers['ApiKey'] = Environment.apikey;
    Response response = await _dio.delete(url);
    return response;
  }

  Future<Response> postNew(url,
      {bool withToken = true, body, queryParam}) async {
    log('--- POST NEW');
    log('--- URL : $url');
    String accessToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjhjYTc4NjUzLTQxYWEtNGZkYi05YmFhLWY1Yjg5Yzk2N2JlZCIsImlhdCI6MTcxMDc0Njg1Mn0.VeN2gOhwV2xtXb3u03_skZmKEHROCcO6lpHEEfpvnW4';
    _dio.interceptors.add(LoggingInterceptor());

    if (withToken) {
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    }
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['ApiKey'] = Environment.apikey;

    dynamic formBody;
    if (body != null) {
      log('DIO POST BODY $body');
      formBody = FormData.fromMap(body);
    }

    log('QUERY $queryParam');

    try {
      Response response =
          await _dio.post(url, data: formBody, queryParameters: queryParam);
      log('DIO RESPONSE ${response.data}');
      return response;
    } on DioException catch (error) {
      log('DIO ERROR ${handleErrorDio(error)}');
      log('DIO ERROR ${error.response!.data}');
      return error.response!;
    }
  }
}

class LoggingInterceptor extends InterceptorsWrapper {
  int _maxCharactersPerLine = 200;
}
