import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:testapp/request/global_config.dart';

class CacheObject {
  Response response;
  int timeStamp;
  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

class NetCache extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();

  @override
   onRequest(RequestOptions options) async {
    //禁止缓存就不拦截
    if (!Global.profile.cache.enable) return options;

    bool refresh = options.extra['refresh'] == true;
    //若是刷新，先删除相关缓存
    if (refresh) {
      // if (options.extra['list'] == true) {
      //   //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
      //   cache.removeWhere((key, v) => key.contains(options.path));
      // } else {
          delete(options.uri.toString());
      // }
          return options;

    }

    if (options.extra['noCache'] != true && options.method.toLowerCase() == 'get') {
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内存
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp)/1000<Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          cache.remove(key);
        }
      }
    }
  }

  @override
  Future onResponse(Response response) async {
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
  }

  _saveCache(Response object) {
    RequestOptions options = object.request;
    if (options.extra['noCache'] != true && options.method.toLowerCase() == 'get') {
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
