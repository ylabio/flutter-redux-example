import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_redux_example/src/store/app/app_state.dart';
import 'package:flutter_redux_example/src/store/auth/store.dart';
import 'package:flutter_redux_example/src/ui/screens/home_screen.dart';
import 'package:flutter_redux_example/src/ui/screens/login_screen.dart';
import 'package:flutter_redux_example/src/ui/screens/detail_screen.dart';

class AppRouter {
  static final homeRoute = '/';
  static final loginRoute = '/login';
  static final detailRoute = '/detail';

  static routes() {
    return {
      homeRoute: (context) {
        return StoreConnector<AppState, AuthState>(
          converter: (store) => store.state.authState,
          builder: (_, authState) {
            if (authState.hasToken) {
              return HomeScreen();
            }
            return LoginScreen();
          },
        );
      },
      loginRoute: (context) => LoginScreen(),
      detailRoute: (context) => DetailScreen(),
    };
  }
}
