import 'dart:ui';
import './view/ListView.dart';
import './view/BottomBar.dart';

import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(255, 255, 255, 0),
        splashColor: Colors.white70,
      ),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyPage('Home'),
        '/b': (BuildContext context) => MyPage('Explore'),
        '/c': (BuildContext context) => RandomWords(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomBarDemo();
  }
}


class MyPage extends StatelessWidget {
  final String labeltext;
  MyPage(this.labeltext);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('page'),
      ),
      body: Text(labeltext),
    );
  }
}
