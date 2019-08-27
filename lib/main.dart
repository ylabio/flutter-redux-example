import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_redux_example/src/store/app_state.dart';
import 'package:flutter_redux_example/src/store/app_reducer.dart';
import 'package:flutter_redux_example/src/utils/app_logger.dart';
import 'package:flutter_redux_example/src/utils/app_router.dart';
import 'package:flutter_redux_example/src/utils/http.dart';

void main() {
  AppLogger()..isDebug = true;

  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, LoggingMiddleware.printer()],
  );

  Http.init(store);

  SharedPreferences.getInstance().then((prefs) {
    runApp(App(store: store, prefs: prefs));
  });
}

class App extends StatelessWidget {
  final Store store;
  final SharedPreferences prefs;

  const App({Key key, this.store, this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Example',
        theme: ThemeData(),
        initialRoute: AppRouter.loginRoute,
        routes: AppRouter.routes(),
      ),
    );
  }
}
