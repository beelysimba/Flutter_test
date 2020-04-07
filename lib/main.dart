import 'dart:ui';
import './view/ListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:english_words/english_words.dart';

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

class BottomBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomBarDemoState();
  }
}

class BottomBarDemoState extends State<BottomBarDemo> {
  int currentIndex = 0;
  String page = 'Home';
  void _tapBottomBarHandler(int index) {
    setState(() {
      currentIndex = index;
      page = index == 0 ? 'Home':(index==1?'explore':'history'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            //  leading: IconButton(
            //  icon: Icon(Icons.menu),
            //  onPressed: () => debugPrint('left button did click'),
            //  tooltip: 'navigation'
            //  ),
            title: Text('welcome'),
            elevation: 0.0,
            bottom: TabBar(
                unselectedLabelColor: Colors.black38,
                indicatorColor: Colors.blueGrey[100],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 1.0,
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.local_activity)),
                  Tab(icon: Icon(Icons.local_mall)),
                  Tab(icon: Icon(Icons.local_movies)),
                ]),
          ),
          body: TabBarView(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Icon(Icons.local_activity, size: 128.0, color: Colors.black12),
               Text(page),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               Icon(Icons.local_mall, size: 128.0, color: Colors.black12),
               Text(page),
               ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.local_movies, size: 128.0, color: Colors.black12),
               Text(page),
              ],
            ),
          ]),
          drawer: Drawer(
              child: ListView(padding: EdgeInsets.all(8.0), children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('隔壁老王'),
              accountEmail: Text('www.baidu.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://c-ssl.duitang.com/uploads/item/202004/01/20200401213738_ty4L3.thumb.1000_0.jpeg'),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://c-ssl.duitang.com/uploads/item/201208/12/20120812185759_xVuw5.thumb.1000_0.jpeg'),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.blueGrey, BlendMode.hardLight),
                  )),
            ),
            ListTile(
              leading:
                  Icon(Icons.local_cafe, size: 28.0, color: Colors.deepOrange),
              title: Text('first', textAlign: TextAlign.left),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading:
                  Icon(Icons.local_drink, size: 28.0, color: Colors.deepOrange),
              title: Text('second', textAlign: TextAlign.left),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading:
                  Icon(Icons.local_pizza, size: 28.0, color: Colors.deepOrange),
              title: Text('third', textAlign: TextAlign.left),
              onTap: () => Navigator.of(context).pop(),
            ),
          ])),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: _tapBottomBarHandler,
            fixedColor: Colors.lightBlue[280],
            items: [
              BottomNavigationBarItem(
                  title: Text('Home'), icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  title: Text('Explore'), icon: Icon(Icons.explore)),
              BottomNavigationBarItem(
                  title: Text('History'), icon: Icon(Icons.history)),
            ],
          ),
          //RandomWords(),
        ));
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
    final word = WordPair.random();
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
