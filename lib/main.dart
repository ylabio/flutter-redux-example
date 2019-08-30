import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_redux_example/src/repository/auth/auth_api_provider.dart';
import 'package:flutter_redux_example/src/repository/auth/auth_storage_provider.dart';
import 'package:flutter_redux_example/src/repository/auth/repository.dart';
import 'package:flutter_redux_example/src/repository/ticket/ticket_api_provider.dart';
import 'package:flutter_redux_example/src/repository/ticket/repository.dart';
import 'package:flutter_redux_example/src/store/app/app_state.dart';
import 'package:flutter_redux_example/src/store/app/app_reducer.dart';
import 'package:flutter_redux_example/src/store/auth/store.dart';
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

  Http()..init(store);

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
    final authRepository = AuthRepository(
      AuthStorageProvider(prefs),
      AuthApiProvider(),
    );
    final ticketRepository = TicketRepository(
      TicketApiProvider(),
    );

    // remind user session
    store.dispatch(remind(authRepository));

    return StoreProvider<AppState>(
      store: store,
      child: MultiProvider(
        providers: [
          Provider<AuthRepository>.value(value: authRepository),
          Provider<TicketRepository>.value(value: ticketRepository),
        ],
        child: MaterialApp(
          title: 'Flutter Redux Example',
          theme: ThemeData(),
          initialRoute: AppRouter.homeRoute,
          routes: AppRouter.routes(),
        ),
      ),
    );
  }
}
