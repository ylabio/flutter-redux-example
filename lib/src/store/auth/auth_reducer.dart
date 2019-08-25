import 'package:redux/redux.dart';

import 'auth_actions.dart';
import 'auth_state.dart';

Reducer<AuthState> authStateReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthLoading>(_loading),
  TypedReducer<AuthState, AuthLoggedIn>(_loggedIn),
  TypedReducer<AuthState, AuthLoggedOut>(_loggedOut),
  TypedReducer<AuthState, AuthSetUser>(_setUser),
]);

AuthState _loading(AuthState authState, AuthLoading action) {
  return authState.copyWith(isLoading: true);
}

AuthState _loggedIn(AuthState authState, AuthLoggedIn action) {
  return authState.copyWith(
    user: action.user ?? null,
    token: action.token,
    hasToken: action.token.isNotEmpty,
    isLoading: false,
  );
}

AuthState _loggedOut(AuthState authState, AuthLoggedOut action) {
  return authState.copyWith(
    user: null,
    token: '',
    hasToken: false,
    isLoading: false,
  );
}

AuthState _setUser(AuthState authState, AuthSetUser action) {
  return authState.copyWith(
    user: action.user,
  );
}
