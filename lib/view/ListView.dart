
import '../model/post.dart';
import 'package:flutter/material.dart';

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
