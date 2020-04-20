
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './intl/try_messages_all.dart';

class DemoLocation {

   static DemoLocation of(BuildContext context) {
    return Localizations.of<DemoLocation>(context, DemoLocation);
  }

    static Future<DemoLocation> load(Locale locale) {
      final String name = locale.countryCode.isEmpty?locale.languageCode:locale.toString();
      final String localeName = Intl.canonicalizedLocale(name);
      return initializeMessages(localeName).then((bool _) {
        Intl.defaultLocale = localeName;
        return DemoLocation();
      });
    }
  String get title => Intl.message(
    'hello',
    name: 'title',
    desc: 'demo localizations'
    );

  String greet(String name) => Intl.message(
    'hello $name',
    name: 'greet',
    desc: 'greet someone',
    args: [name],
    );
}


class DemoLocationDeleagte extends LocalizationsDelegate<DemoLocation>  {
  DemoLocationDeleagte();

  @override
  Future<DemoLocation> load(Locale locale) {
    return DemoLocation.load(locale);
  }

  @override
  bool isSupported(Locale locale) {
    return true;
  }
  @override
  bool shouldReload(LocalizationsDelegate<DemoLocation> old) {
    return false;
  }
}
