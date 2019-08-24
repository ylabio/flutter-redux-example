import 'package:flutter_redux_example/src/ui/screens/home_screen.dart';
import 'package:flutter_redux_example/src/ui/screens/login_screen.dart';
import 'package:flutter_redux_example/src/ui/screens/detail_screen.dart';

class Router {
  static final homeRoute = '/home';
  static final loginRoute = '/login';
  static final detailRoute = '/detail';

  static routes() {
    return {
      homeRoute: (context) => HomeScreen(),
      loginRoute: (context) => LoginScreen(),
      detailRoute: (context) => DetailScreen(),
    };
  }
}
