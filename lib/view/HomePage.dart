

import 'package:flutter/material.dart';
import '../request/requestManager.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center (
       child: Text('Home', style: TextStyle(fontSize: 30.0)),
     ),
     );
  }
}