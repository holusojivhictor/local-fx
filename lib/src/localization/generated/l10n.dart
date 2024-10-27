// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `For`
  String get forString {
    return Intl.message(
      'For',
      name: 'forString',
      desc: '',
      args: [],
    );
  }

  /// `24h Low`
  String get dailyLow {
    return Intl.message(
      '24h Low',
      name: 'dailyLow',
      desc: '',
      args: [],
    );
  }

  /// `24h High`
  String get dailyHigh {
    return Intl.message(
      '24h High',
      name: 'dailyHigh',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Search Country`
  String get searchCountry {
    return Intl.message(
      'Search Country',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Choose a language`
  String get chooseLanguage {
    return Intl.message(
      'Choose a language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `are listed below`
  String get areListedBelow {
    return Intl.message(
      'are listed below',
      name: 'areListedBelow',
      desc: '',
      args: [],
    );
  }

  /// `Sync with device theme`
  String get syncWithDeviceTheme {
    return Intl.message(
      'Sync with device theme',
      name: 'syncWithDeviceTheme',
      desc: '',
      args: [],
    );
  }

  /// `Viewing daily changes for:`
  String get viewingDailyChangesFor {
    return Intl.message(
      'Viewing daily changes for:',
      name: 'viewingDailyChangesFor',
      desc: '',
      args: [],
    );
  }

  /// `The available currency pairs`
  String get availableCurrencyPairs {
    return Intl.message(
      'The available currency pairs',
      name: 'availableCurrencyPairs',
      desc: '',
      args: [],
    );
  }

  /// `We provide chart data for `
  String get viewDataForListedSymbols {
    return Intl.message(
      'We provide chart data for ',
      name: 'viewDataForListedSymbols',
      desc: '',
      args: [],
    );
  }

  /// `Quote and price data are currently unavailable`
  String get failedQuoteAndPriceFetch {
    return Intl.message(
      'Quote and price data are currently unavailable',
      name: 'failedQuoteAndPriceFetch',
      desc: '',
      args: [],
    );
  }

  /// `None found. Please switch to a different currency.`
  String get noPairFound {
    return Intl.message(
      'None found. Please switch to a different currency.',
      name: 'noPairFound',
      desc: '',
      args: [],
    );
  }

  /// `We provide up-to-date trend data for forex pairs across a wide range of currencies, including USD, EUR, and many others.`
  String get weProvideTrendDataForPairs {
    return Intl.message(
      'We provide up-to-date trend data for forex pairs across a wide range of currencies, including USD, EUR, and many others.',
      name: 'weProvideTrendDataForPairs',
      desc: '',
      args: [],
    );
  }

  /// `We show you currency pairs relevant to your locale.`
  String get explanationOne {
    return Intl.message(
      'We show you currency pairs relevant to your locale.',
      name: 'explanationOne',
      desc: '',
      args: [],
    );
  }

  /// `We decide your locale based on your current location if you have permissions on.`
  String get explanationTwo {
    return Intl.message(
      'We decide your locale based on your current location if you have permissions on.',
      name: 'explanationTwo',
      desc: '',
      args: [],
    );
  }

  /// `You can switch the locale by tapping on the flag area at the top left corner.`
  String get explanationThree {
    return Intl.message(
      'You can switch the locale by tapping on the flag area at the top left corner.',
      name: 'explanationThree',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
