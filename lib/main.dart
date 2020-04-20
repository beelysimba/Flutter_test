import 'dart:ui';
import './view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './i18n/locations.dart';

void main() => runApp(App());

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



