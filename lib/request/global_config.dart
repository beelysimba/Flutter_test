
import 'package:flutter/material.dart';

class GlobalConfig {
    static bool isDebug = true;//是否是调试模式
    static bool dark = false;

    static Color fontColor = Colors.black54;

//url
    static const String ALL_COURSE = '/api3/course/all_module_courses?';
    static const String ALL_STUDYROUTE = '/api3/study_route/all?';
    static const String APP_HOME = '/api3/app_home/show_v11?';
    static const String HOT_SECTION = '/api3/ranking/hot_section?';
  }