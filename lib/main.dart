import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_example/src/repository/base_api_provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:flutter_redux_example/src/store/app_state.dart';
import 'package:flutter_redux_example/src/store/app_reducer.dart';
import 'package:flutter_redux_example/src/utils/app_logger.dart';
import 'package:flutter_redux_example/src/utils/app_router.dart';

void main() {
  AppLogger()..isDebug = true;

  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, LoggingMiddleware.printer()],
  );

  BaseApiProvider.init(store);

  runApp(App(store: store));
}

class App extends StatelessWidget {
  final Store store;

  const App({Key key, this.store}) : super(key: key);

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
