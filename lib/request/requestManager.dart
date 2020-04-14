import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import './global_config.dart';

class DioManager {
  static DioManager _dioManager;
  static DioManager getInstance() {
    if (_dioManager == null) {
      _dioManager = DioManager();
    }
    return _dioManager;
  }

  static BaseOptions options = new BaseOptions(
      baseUrl: 'https://www.mofunenglish.com',
      connectTimeout: 5000,
      receiveTimeout: 10000,
      //请求头
      headers: {
        'Accept-Language': 'zh-Hans-CN;q=1, en-CN;q=0.9',
        'Accept-Encoding': 'gzip,deflate',
        'Connection': 'keep-alive',
      },
      responseType: ResponseType.plain,
      contentType: Headers.formUrlEncodedContentType,
    );

  Dio  dio ;
  
  void request(String url, Function sucCallBack, Function errCallBack,
      [String method, Map<String, dynamic> params]) {}

  DioManager() {
//BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor(requestBody: GlobalConfig.isDebug));
    dio.interceptors.add(CookieManager(CookieJar()));
  }

    Future get(String url,Map<String, dynamic> params) async {
      if (params == null) {
        params = Map.from({'userid':3465972, 'token': '8cfd69395419f55940580ec105c524da','v':'ios_11.0.9' });
      }else{
        params.addEntries([MapEntry('userid', 3465972), MapEntry('token', '8cfd69395419f55940580ec105c524da'), MapEntry('v', 'ios_11.0.9')]);
      }
      return dio.get(url,queryParameters: params);
    }
  

//handler network
      _error(Function errorCallBack, String error) {
      if (errorCallBack != null) {
        errorCallBack(error);
      }

      void request(String url, Function sucCallBack, Function errCallBack, CancelToken cancelToken,
          [String method, Map<String, dynamic> params]) async {
        params.addEntries([MapEntry('userid', 3465972), MapEntry('token', '8cfd69395419f55940580ec105c524da'), MapEntry('v', 'ios_11.0.9')]);

        Response response;
  
        try {
          if (method == 'GET') {
            if (cancelToken != null) {
              response = await dio.get(url, queryParameters: params, cancelToken: cancelToken);
            } else {
              response = await dio.get(url, queryParameters: params);
            }
          } else if (method == 'POST') {
            if (cancelToken != null){
            response = await dio.post(url, data: params, cancelToken: cancelToken);
            } else {
            response = await dio.post(url, data: params);
           }
        }
        } on DioError catch (error) {
          Response errResponse;
          if (error.response != null) {
            errResponse = error.response;
          } else {
            errResponse = new Response(statusCode: 666);
          }
          // 请求超时
          if (error.type == DioErrorType.CONNECT_TIMEOUT) {
            errResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
          }
          // 一般服务器错误
          else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
            errResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
          }
          _error(errCallBack, error.message);
        }

        if (GlobalConfig.isDebug) {
          print('请求异常url: ' + url);
          print('请求头: ' + dio.options.headers.toString());
        }

        String dataStr = json.encode(response.data);
        Map<String, dynamic> dataMap = json.decode(dataStr);
        if (dataMap == null || dataMap['state'] == 0) {
          _error(
              errCallBack,
              '错误码：' +
                  dataMap['errorCode'].toString() +
                  '，' +
                  response.data.toString());
        } else if (sucCallBack != null) {
          sucCallBack(dataMap);
        }
      }
    }

    request_get(String url, Map<String,dynamic> params, Function sucCallBack,
        Function errCallBack) async {
      request(url, sucCallBack, errCallBack, 'GET', params);
    }

    request_post(String url, Map<String, dynamic> params, Function sucCallBack,
        Function errCallBack) async {
      request(url, sucCallBack, errCallBack, 'POST', params);
    }
  }


/*
 * dio网络请求失败的回调错误码 
 */
class ResultCode {
  //正常返回是1
  static const SUCCESS = 1;

  //异常返回是0
  static const ERROR = 1;

  /// When opening  url timeout, it occurs.
  static const CONNECT_TIMEOUT = -1;

  ///It occurs when receiving timeout.
  static const RECEIVE_TIMEOUT = -2;

  /// When the server response, but with a incorrect status, such as 404, 503...
  static const RESPONSE = -3;

  /// When the request is cancelled, dio will throw a error with this type.
  static const CANCEL = -4;

  /// read the DioError.error if it is not null.
  static const DEFAULT = -5;
}

class LoadingState {
  static const is_Loading = 1;
  static const loading_fail = 2;
  static const loading_suc = 3;
}