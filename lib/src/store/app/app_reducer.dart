import 'app_state.dart';
import 'package:flutter_redux_example/src/store/auth/auth_reducer.dart';
import 'package:flutter_redux_example/src/store/snackbar/snackbar_reducer.dart';
import 'package:flutter_redux_example/src/store/ticket/ticket_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) => AppState(
      authState: authStateReducer(state.authState, action),
      snackbarState: snackbarStateReducer(state.snackbarState, action),
      ticketState: ticketStateReducer(state.ticketState, action),
    );
