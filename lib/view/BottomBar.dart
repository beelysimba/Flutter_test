import 'package:flutter/material.dart';

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
