
import 'package:flutter/material.dart';
import 'package:testapp/view/login.dart';

class SquarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return LoginRoute();
            }));
          }),
    );
  }
}