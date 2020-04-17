
import 'package:flutter/material.dart';

class SquarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: (){
            Navigator.of(context).pushNamed('login');
          }),
    );
  }
}