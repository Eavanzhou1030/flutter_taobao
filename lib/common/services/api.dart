import 'package:dio/dio.dart';
import 'dart:collection';
import 'code.dart';
import 'result_data.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/response_interceptor.dart';

class HttpManager {
  static const CONNECT_TYPE_JSON = 'application/json';
  static const CONNECT_TYPE_FORM = 'application/x-www-from-urlencoded';

  Dio _dio = new Dio();

  HttpManager() {
    _dio.interceptors.add(HeaderInterceptors());
    _dio.interceptors.add(LogInterceptors());
    _dio.interceptors.add(ErrorInterceptors(_dio));
    _dio.interceptors.add(ResponseInterceptors());
  }

  /**
   * 封装网络请求
   * [url]  请求url
   * [params]  请求参数
   * [header]  外加头部信息
   * [option]  配置信息
   */
  netFetch(url, params, Map<String, dynamic> header, Options option, {noTip = false}) async {
    Map<String, dynamic> headers = new HashMap();
    if(header != null) {
      headers.addAll(header);
    }

    if(option != null) {
      option.headers = headers;
    } else {
      option = Options(method: 'get');
      option.headers = headers;
    }

    resultError(DioError e) {
      Response errorResponse;
      if(e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: 666);
      }
      if(e.type == DioErrorType.CONNECT_TIMEOUT || e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch(e) {
      return resultError(e);
    }

    if(response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }
}

final HttpManager httpManager = HttpManager();