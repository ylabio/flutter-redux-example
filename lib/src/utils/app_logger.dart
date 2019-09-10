import 'app_errors.dart';

class AppLogger {
  bool _isDebug = false;

  static final AppLogger _singleton = AppLogger._internal();

  factory AppLogger() => _singleton;

  AppLogger._internal();

  set isDebug(bool debug) {
    _isDebug = debug;
  }

  void error(AppBaseError error) {
    if (_isDebug) {
      print(error);
      return;
    }
  }
}
