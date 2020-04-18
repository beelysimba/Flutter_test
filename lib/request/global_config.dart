
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/index.dart';
import 'requestCache.dart';
import 'DioManager.dart';

class GlobalConfig {

    static bool dark = false;
    static Color fontColor = Colors.black54;

//url
    static const String ALL_COURSE = '/api3/course/all_module_courses?';
    static const String ALL_STUDYROUTE = '/api3/study_route/all?';
    static const String APP_HOME = '/api3/app_home/show_v11?';
    static const String HOT_SECTION = '/api3/ranking/hot_section?';
    static const String USER_LOGIN = '/api3/user/login?';
    static const String USER_PROFILE = '/api3/user/profile?';
  }

  const _themes = <MaterialColor>[
    Colors.blue,
    Colors.teal,
    Colors.red,
  ];

  class Global {
    
    static SharedPreferences _prefs;
    //用户偏好
    static Profile profile = Profile();
    //网络存储
    static NetCache netcache = NetCache();
    //主题
    static List<MaterialColor> get themes => _themes;
    //是否为release版本
    static bool get isRelease => bool.fromEnvironment("dart.vm.product");

    static Future init() async {
      WidgetsFlutterBinding.ensureInitialized();
      _prefs = await SharedPreferences.getInstance();
      var _profile = _prefs.getString('profile');
      if (_profile != null) {
        try {
          profile = Profile.fromJson(jsonDecode(_profile));
        } catch (e) {
          print(e);
        }
      }
      //设置默认缓存策略
      profile.cache = profile.cache??CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

     DioManager.preSet();
    }

    //持久化profile信息
    static saveProfile() => _prefs.setString('profile', jsonEncode(profile.toJson()));

  }