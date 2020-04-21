import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:testapp/request/global_config.dart';
import 'package:testapp/view/profile/profileNotifier.dart';

import './view/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './i18n/locations.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // 此处调用是为了全局初始化 global.init(),参考：https://book.flutterchina.club/chapter14/flutter_app_startup.html
  await Global.init().then((e) {
    runApp(new App());
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(builder: (BuildContext context,
          ThemeModel theme, LocaleModel local, Widget child) {
        return MaterialApp(
          locale: local.getLocale(),
          // localeResolutionCallback: (Locale locale, Iterable<Locale> supported){
          //     return Locale('en','US');
          // },
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            DemoLocationDeleagte(),
          ],
          supportedLocales: [
            Locale('en', 'US'),
            Locale('zh', 'CN'),
            Locale('ja', 'JP'),
          ],
          debugShowCheckedModeBanner: false,
          // home: Home(),
          theme: ThemeData(
            primarySwatch: theme.theme,
          ),
          onGenerateTitle: (context) {
            return DemoLocation.of(context).title;
          },
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => BottomBarDemo(),
            '/home': (BuildContext context) => HomePage(),
            '/study': (BuildContext context) => StudyPage(),
            '/person': (BuildContext context) => PersonPage(),
            '/login': (BuildContext context) => LoginRoute(),
          },
        );
      }),
    );
  }
}
