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

  /// `AppFood`
  String get appName {
    return Intl.message(
      'AppFood',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
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

  /// `Find Food`
  String get titleOnboarding1 {
    return Intl.message(
      'Find Food',
      name: 'titleOnboarding1',
      desc: '',
      args: [],
    );
  }

  /// `Fast Delivery `
  String get titleOnboarding2 {
    return Intl.message(
      'Fast Delivery ',
      name: 'titleOnboarding2',
      desc: '',
      args: [],
    );
  }

  /// `Skilled Chefs`
  String get titleOnboarding3 {
    return Intl.message(
      'Skilled Chefs',
      name: 'titleOnboarding3',
      desc: '',
      args: [],
    );
  }

  /// `With Best Of Love`
  String get desOnboarding1 {
    return Intl.message(
      'With Best Of Love',
      name: 'desOnboarding1',
      desc: '',
      args: [],
    );
  }

  /// `With Super Riders`
  String get desOnboarding2 {
    return Intl.message(
      'With Super Riders',
      name: 'desOnboarding2',
      desc: '',
      args: [],
    );
  }

  /// `With Fantastic Tastes`
  String get desOnboarding3 {
    return Intl.message(
      'With Fantastic Tastes',
      name: 'desOnboarding3',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address in format: yourname@example.com`
  String get invalidEmailAddress {
    return Intl.message(
      'Please enter your email address in format: yourname@example.com',
      name: 'invalidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get signIn {
    return Intl.message(
      'Login',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get email {
    return Intl.message(
      'Enter Your Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account?`
  String get noAccount {
    return Intl.message(
      'Create New Account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `At least eight characters`
  String get invalidPasswordLength {
    return Intl.message(
      'At least eight characters',
      name: 'invalidPasswordLength',
      desc: '',
      args: [],
    );
  }

  /// `At least one letter`
  String get invalidPasswordOneLetter {
    return Intl.message(
      'At least one letter',
      name: 'invalidPasswordOneLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one special letter`
  String get invalidPasswordOneSpecialLetter {
    return Intl.message(
      'At least one special letter',
      name: 'invalidPasswordOneSpecialLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one number`
  String get invalidPasswordOneNumber {
    return Intl.message(
      'At least one number',
      name: 'invalidPasswordOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least one capital letter`
  String get invalidPasswordOneCapitalLetter {
    return Intl.message(
      'At least one capital letter',
      name: 'invalidPasswordOneCapitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `Login Your Account`
  String get titleLogin {
    return Intl.message(
      'Login Your Account',
      name: 'titleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get mostPopular {
    return Intl.message(
      'Most Popular',
      name: 'mostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Nearby Restautant`
  String get nearby {
    return Intl.message(
      'Nearby Restautant',
      name: 'nearby',
      desc: '',
      args: [],
    );
  }

  /// `Healthy`
  String get healthy {
    return Intl.message(
      'Healthy',
      name: 'healthy',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Add To Card`
  String get addToCard {
    return Intl.message(
      'Add To Card',
      name: 'addToCard',
      desc: '',
      args: [],
    );
  }

  /// `View Restautant`
  String get showRestaurent {
    return Intl.message(
      'View Restautant',
      name: 'showRestaurent',
      desc: '',
      args: [],
    );
  }

  /// `Added Items`
  String get addedItems {
    return Intl.message(
      'Added Items',
      name: 'addedItems',
      desc: '',
      args: [],
    );
  }

  /// `Go To Cart`
  String get goToCart {
    return Intl.message(
      'Go To Cart',
      name: 'goToCart',
      desc: '',
      args: [],
    );
  }

  /// `Show Comment`
  String get showComment {
    return Intl.message(
      'Show Comment',
      name: 'showComment',
      desc: '',
      args: [],
    );
  }

  /// `Review Payment`
  String get reviewPayment {
    return Intl.message(
      'Review Payment',
      name: 'reviewPayment',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get nameCart {
    return Intl.message(
      'Cart',
      name: 'nameCart',
      desc: '',
      args: [],
    );
  }

  /// `Your email or password is incorrect`
  String get erEmailOrPasswordInvalid {
    return Intl.message(
      'Your email or password is incorrect',
      name: 'erEmailOrPasswordInvalid',
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
