import 'package:dio/dio.dart';
import 'package:flutter_taobao/common/services/code.dart';
import 'package:flutter_taobao/common/services/result_data.dart';

/**
 * Token拦截器
 */
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    RequestOptions options = response.request;
    try {
      if(options.contentType != null && options.contentType.primaryType == 'text') {
        return ResultData(response.data, true, Code.SUCCESS);
      }
      if(response.statusCode == 200 || response.statusCode == 201) {
        return ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    } catch(e) {
      print(e.toString() + options.path);
      return ResultData(response.data, false, response.statusCode, headers: response.headers);
    }

  }
}