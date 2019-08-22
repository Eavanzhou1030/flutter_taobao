import 'package:dio/dio.dart';
import 'package:flutter_taobao/common/config/config.dart';

/**
 * Log拦截器
 */

class LogInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if(Config.DEBUG) {
      print("请求Url: ${options.path}");
      print("请求头：" + options.headers.toString());
      if (options.data != null) {
        print("请求参数：" + options.data.toString());
      }
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if(Config.DEBUG) {
      if(response.data != null) {
        print('返回参数：' + response.toString());
      }
    }
    return response;
  }
}