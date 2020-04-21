import 'dart:ui';
import 'package:testapp/request/global_config.dart';

import './view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './i18n/locations.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // 此处调用是为了全局初始化 global.init(),参考：https://book.flutterchina.club/chapter14/flutter_app_startup.html
  await Global.init().then((e) {
    runApp(new App());
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ja'),
      // localeResolutionCallback: (Locale locale, Iterable<Locale> supported){
      //     return Locale('en','US');
      // },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DemoLocationDeleagte(),
      ],
      supportedLocales: [
        Locale('en','US'),
        Locale('zh','CN'),
        Locale('ja','JP'),
      ],
      debugShowCheckedModeBanner: false,
      // home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(255, 255, 255, 0),
        splashColor: Colors.white70,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => BottomBarDemo(),
        '/home': (BuildContext context) => HomePage(),
        '/study': (BuildContext context) => StudyPage(),
        '/person': (BuildContext context) => PersonPage(),
        '/login': (BuildContext context) => LoginRoute(),
      },
    );
  }
}



