import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:testapp/models/index.dart';
import './global_config.dart';

class DioManager {
  BuildContext context;
  Options _options;
  DioManager([this.context]) {
    _options = Options(extra: {'context': context});
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

  static Map<String, dynamic> paraGet = {'v': 'ios_11.0.9'};

  static Dio dio = Dio(options);

  static void preSet() {
    // 添加缓存插件
    dio.interceptors.add(Global.netcache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
  }

  void request(String url, Function sucCallBack, Function errCallBack,
      [String method, Map<String, dynamic> params]) {}

  Future get(String url, Map<String, dynamic> params) async {
    if (params == null) {
      params = paraGet;
    } else {
      params.addAll(paraGet);
    }
    return dio.get(url,
        options: _options.merge(contentType: Headers.jsonContentType, extra: {
          "noCache": false, //接口缓存
        }),
        queryParameters: params);
  }

  Future<UserId> login(String name, String pwd) async {
    Map<String, dynamic> para = {
      'account': name,
      'password': pwd,
    };
    var result = await dio.post(
      GlobalConfig.USER_LOGIN,
      queryParameters: paraGet,
      data: para,
      options: _options.merge(contentType: Headers.formUrlEncodedContentType),
    );
    //登录成功后更新公共头，带上用户信息
    var data = json.decode(result.data);
    UserId userId = UserId.fromJson(data);
    paraGet['user_id'] = userId.id;
    paraGet['token'] = userId.token;

    // {'userid':userId.id,'token':userId.token,};
    // String basic = "userid:_$userId.id&token:_$userId.token";
    // dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空缓存并更新

    Global.netcache.cache.clear();
    Global.profile.token = userId.token;
    Global.profile.lastLogin = name;
    return userId;
  }

  Future<User> userInfo() async {
    var result = await DioManager().get(GlobalConfig.USER_PROFILE, null);
    var data = json.decode(result.data);
    User user = User.fromJson(data);
    Global.profile.user = user;
    return user;
  }

//handler network
  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }

    void request(String url, Function sucCallBack, Function errCallBack,
        CancelToken cancelToken,
        [String method, Map<String, dynamic> params]) async {
      if (params == null || params.isEmpty) {
        params = paraGet;
      } else {
        params.addAll(paraGet);
      }
      Response response;

      try {
        if (method == 'GET') {
          if (cancelToken != null) {
            response = await dio.get(url,
                queryParameters: params, cancelToken: cancelToken);
          } else {
            response = await dio.get(url, queryParameters: params);
          }
        } else if (method == 'POST') {
          if (cancelToken != null) {
            response =
                await dio.post(url, data: params, cancelToken: cancelToken);
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

  request_get(String url, Map<String, dynamic> params, Function sucCallBack,
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
