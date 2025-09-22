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

class JapaneseSpeechCompareS {
  JapaneseSpeechCompareS();

  static JapaneseSpeechCompareS? _current;

  static JapaneseSpeechCompareS get current {
    assert(
      _current != null,
      'No instance of JapaneseSpeechCompareS was loaded. Try to initialize the JapaneseSpeechCompareS delegate before accessing JapaneseSpeechCompareS.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<JapaneseSpeechCompareS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = JapaneseSpeechCompareS();
      JapaneseSpeechCompareS._current = instance;

      return instance;
    });
  }

  static JapaneseSpeechCompareS of(BuildContext context) {
    final instance = JapaneseSpeechCompareS.maybeOf(context);
    assert(
      instance != null,
      'No instance of JapaneseSpeechCompareS present in the widget tree. Did you add JapaneseSpeechCompareS.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static JapaneseSpeechCompareS? maybeOf(BuildContext context) {
    return Localizations.of<JapaneseSpeechCompareS>(
      context,
      JapaneseSpeechCompareS,
    );
  }

  /// `Retry`
  String get jscRetry {
    return Intl.message('Retry', name: 'jscRetry', desc: '', args: []);
  }

  /// `This feature requires network connectivity. Please check your connection and try again.`
  String get jscNetworkError {
    return Intl.message(
      'This feature requires network connectivity. Please check your connection and try again.',
      name: 'jscNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `The app requires microphone and Google Speech Services permissions to recognize speech. Please grant permissions in Settings.`
  String get jscAndroidPermissionError {
    return Intl.message(
      'The app requires microphone and Google Speech Services permissions to recognize speech. Please grant permissions in Settings.',
      name: 'jscAndroidPermissionError',
      desc: '',
      args: [],
    );
  }

  /// `The app requires microphone permission to recognize speech. Please grant permission in Settings.`
  String get jscIOSPermissionError {
    return Intl.message(
      'The app requires microphone permission to recognize speech. Please grant permission in Settings.',
      name: 'jscIOSPermissionError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<JapaneseSpeechCompareS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'mn'),
      Locale.fromSubtags(languageCode: 'ms'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'ne'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'si'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<JapaneseSpeechCompareS> load(Locale locale) =>
      JapaneseSpeechCompareS.load(locale);
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
