
import '../model/post.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
 
class ListViewDemo extends StatelessWidget {
  //list of img & text   
Widget _listItemBuilder(BuildContext context, int index){
  return Container(
    color: Colors.white,
    margin: EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        Image.network(posts[index].imgUrl),
        SizedBox(height: 10),
        Text(
           posts[index].title,
           style: Theme.of(context).textTheme.subhead,
        ),
      SizedBox(height: 10.0),
      ],
    ),
    );
}

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
       itemCount: posts.length,
       itemBuilder: _listItemBuilder,
     );
  }
}


//RandomWord list
class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => RandomWordState();
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    final bool hasSaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        hasSaved ? Icons.favorite : Icons.favorite_border,
        color: hasSaved ? Colors.red : Colors.grey,
      ),
      onTap: () {
        setState(() {
          if (hasSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
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
        });
  }

  @override
  Widget build(BuildContext context) {
    // final word = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: Text('Name Generator'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.library_books), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext contex) {
      final Iterable<ListTile> tiles = _saved.map(
        (WordPair pair) {
          return new ListTile(
              title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ));
        },
      );
      final List<Widget> divided = ListTile.divideTiles(
              context: context, tiles: tiles, color: Colors.blueGrey)
          .toList();

      return new Scaffold(
        appBar: new AppBar(title: const Text('Saved Suggestions')),
        body: new ListView(children: divided),
      );
    }));
  }
}
