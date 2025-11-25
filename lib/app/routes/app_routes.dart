// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';
abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const SIGNIN = _Paths.SIGNIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const CHATBOT = _Paths.CHATBOT;
  static const OBJECTDETECTION = _Paths.OBJECTDETECTION;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const SIGNIN = '/signin';
  static const SIGNUP = '/signup';
  static const CHATBOT = '/chatbot';
  static const OBJECTDETECTION = '/objectdetection';
}
