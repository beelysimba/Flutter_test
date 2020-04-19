import 'dart:ui';
import 'package:testapp/view/HomePage.dart';
import 'package:testapp/view/SquarePage.dart';
import 'package:testapp/view/StudyPage.dart';
import 'package:testapp/view/login.dart';

import './view/BottomBar.dart';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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



