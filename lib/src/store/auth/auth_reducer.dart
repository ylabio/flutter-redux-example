import 'package:redux/redux.dart';

import 'auth_actions.dart';
import 'auth_state.dart';

Reducer<AuthState> authStateReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthLoading>(_loading),
  TypedReducer<AuthState, AuthLoaded>(_loaded),
  TypedReducer<AuthState, AuthLoggedIn>(_loggedIn),
  TypedReducer<AuthState, AuthLoggedOut>(_loggedOut),
  TypedReducer<AuthState, AuthSetUser>(_setUser),
  TypedReducer<AuthState, AuthError>(_error),
  TypedReducer<AuthState, AuthClearError>(_clear),
]);

AuthState _loading(AuthState authState, AuthLoading action) {
  return authState.copyWith(isLoading: true, error: null);
}

AuthState _loaded(AuthState authState, AuthLoaded action) {
  return authState.copyWith(isLoading: false, error: null);
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

AuthState _error(AuthState authState, AuthError action) {
  return authState.copyWith(
    error: action.error,
  );
}

AuthState _clear(AuthState authState, AuthClearError action) {
  return authState.copyWith(
    error: null,
  );
}
