import 'package:flutter/material.dart';
import './HomePage.dart';
import './StudyPage.dart';
import './SquarePage.dart';

class BottomBarDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomBarDemoState();
  }
}

class BottomBarDemoState extends State<BottomBarDemo> {
  final List _pages = [
    HomePage(),
    StudyPage(),
    SquarePage(),
  ];
  
  int currentIndex = 0;
  var currentpage ;
  
  @override
  void initState() { 
    super.initState();
    currentpage = _pages[currentIndex];
  }

  void _tapBottomBarHandler(int index) {
    setState(() {
      currentIndex = index;
      currentpage = _pages[currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: _tapBottomBarHandler,
            fixedColor: Colors.lightBlue,
            items: [
              BottomNavigationBarItem(
                  title: Text('探索'), icon: Icon(Icons.explore)),
              BottomNavigationBarItem(
                  title: Text('学习'), icon: Icon(Icons.my_location)),
              BottomNavigationBarItem(
                  title: Text('广场'), icon: Icon(Icons.message)),
            ],
          ),
          body: currentpage,
          //RandomWords(),
        )
        );
  }
}
