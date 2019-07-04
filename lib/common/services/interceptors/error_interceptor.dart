import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_taobao/common/services/code.dart';
import 'package:flutter_taobao/common/services/result_data.dart';

// 是否需要显示弹窗
const NOT_TIP_KEY= 'noTip';

/**
 * 错误拦截
 */
class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    // 没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(ResultData(Code.errorHandleFunction(Code.NETWORK_ERROR, '', false), false, Code.NETWORK_ERROR));
    }
    return options;
  }
}