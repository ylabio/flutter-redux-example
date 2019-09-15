import 'package:meta/meta.dart';

import 'package:flutter_redux_example/src/store/auth/auth_state.dart';
import 'package:flutter_redux_example/src/store/snackbar/snackbar_state.dart';
import 'package:flutter_redux_example/src/store/ticket/ticket_state.dart';

@immutable
class AppState {
  final AuthState authState;
  final SnackbarState snackbarState;
  final TicketState ticketState;

  const AppState({
    @required this.authState,
    @required this.snackbarState,
    @required this.ticketState,
  });

  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
      snackbarState: SnackbarState.initial(),
      ticketState: TicketState.initial(),
    );
  }

  AppState copyWith({AuthState authState}) {
    return AppState(
      authState: authState ?? this.authState,
      snackbarState: snackbarState ?? this.snackbarState,
      ticketState: ticketState ?? this.ticketState,
    );
  }
}
