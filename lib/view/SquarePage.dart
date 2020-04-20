import 'package:flutter/material.dart';
import 'package:testapp/models/index.dart';
import 'package:testapp/request/global_config.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  bool isLogin = (Global.profile.user != null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          isLogin ? UserInfoView() : Divider(),
          RaisedButton(
              child: Text('login'),
              onPressed: () async {
                var res = await Navigator.of(context).pushNamed('/login');
                if (res!=null) {
                  setState(() {
                    isLogin = true;
                  });
                  print('back value $res');
                }
              }),
        ]));
  }
}

class UserInfoView extends StatelessWidget {
  final User user = Global.profile.user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(user.photo['80x80'])),
        title: Text(user.name),
        subtitle: Text(user.intro),
      ),
    );
  }
}
