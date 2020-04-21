import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChDemoLocation {
  final Locale locale;
  ChDemoLocation(this.locale);
  static ChDemoLocation of(BuildContext context) {
    return Localizations.of<ChDemoLocation>(context, ChDemoLocation);
  }

  static Map<String, Map<String, String>> _localized = {
    'en': {
      'title': 'hello',
    },
    'zh': {
      'title': '你好',
    }
  };

  String get title {
    return _localized[locale.languageCode]['title'];
  }
}

class ChDemoLocationDeleagte extends LocalizationsDelegate<ChDemoLocation>  {
  ChDemoLocationDeleagte();

  @override
  Future<ChDemoLocation> load(Locale locale) {
    return SynchronousFuture<ChDemoLocation>(ChDemoLocation(locale));
  }

  @override
  bool isSupported(Locale locale) {
    return true;
  }
  @override
  bool shouldReload(LocalizationsDelegate<ChDemoLocation> old) {
    return false;
  }
}
