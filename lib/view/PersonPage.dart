import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:testapp/models/index.dart';
import 'package:testapp/request/global_config.dart';
import 'package:intl/intl.dart';
import 'package:testapp/view/profile/language.dart';
import 'package:testapp/view/profile/theme_change.dart';
import '../i18n/locations.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  bool isLogin = (Global.profile.user != null);
  DateTime selDate = DateTime.now();
  _showDate() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: selDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));
    if (date == null) return;
    setState(() {
      selDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Locale locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // locale.toString(),
          DemoLocation.of(context)
              .greet(isLogin ? Global.profile.user.name : '游客'),
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isLogin ? UserInfoView(selDate, _showDate) : Divider(),
            RaisedButton(
                child: Text('login'),
                onPressed: () async {
                  var res = await Navigator.of(context).pushNamed('/login');
                  if (res != null && res != 'failed') {
                    setState(() {
                      isLogin = true;
                    });
                    print('back value $res');
                  }
                }),
          ]),
      endDrawer: Drawer(
        // color: Colors.blueGrey[200],
        // padding: EdgeInsets.all(10),
        child: ListView(
          padding: EdgeInsets.only(top:100,left: 10),
          children: <Widget>[
            ListTile(
              title: Text('主题'),
              leading: Icon(Icons.color_lens),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute<Void>(
                    builder: (BuildContext context) {
                  return ThemeChangeRoute();
                }));
              },
            ),
            ListTile(
                title: Text('语言'),
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute<Void>(
                      builder: (BuildContext context) {
                    return LanguageRoute();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}

class Localization {}

class UserInfoView extends StatelessWidget {
  final User user = Global.profile.user;
  final DateTime selectedDate;
  final Function showDatePicker;
  UserInfoView(this.selectedDate, this.showDatePicker);
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(20),
        child: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(user.photo['80x80'])),
            title: Text(user.name),
            subtitle: Text(user.intro),
          ),
          InkWell(
            onTap: showDatePicker,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(DateFormat.yMd().format(selectedDate)),
                  Icon(Icons.arrow_drop_down),
                ]),
          ),
        ]));
  }
}
