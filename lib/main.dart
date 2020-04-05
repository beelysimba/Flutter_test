import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'model/post.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(App());
} 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     home: Home(),
   theme: ThemeData(
     primarySwatch: Colors.yellow
   ),
   );
  }
}

class Home extends StatelessWidget {
Widget _listItemBuilder(BuildContext context, int index){
  return Container(
    color: Colors.white,
    margin: EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        Image.network(posts[index].imgUrl, height: 100),
        SizedBox(height: 30),
        Text(
           posts[index].title,
           style: Theme.of(context).textTheme.subtitle,
        ),
      ],
    ),
    );
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[80],
      //  appBar: AppBar(
      //    title: Text('welcome'),
      //    elevation: 0.0,
      //  ),
     body: RandomWords(),

    //  ListView.builder(
    //    itemCount: posts.length,
    //    itemBuilder: _listItemBuilder,
    //  )
     );
  }
}


class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Text(
      'hello world',
      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontSize: 42.0,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => RandomWordState();
}

class RandomWordState extends State<RandomWords> {
    final _suggestions = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      )
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(15.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
      );
  }
  @override
  Widget build(BuildContext context) {
    final word = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
      ), 
      body: _buildSuggestions(),
    );
  }
}
