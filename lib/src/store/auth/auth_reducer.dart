import 'package:redux/redux.dart';

import 'auth_actions.dart';
import 'auth_state.dart';

Reducer<AuthState> authStateReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthLoading>(_loading),
  TypedReducer<AuthState, AuthUpdate>(_update),
  TypedReducer<AuthState, AuthLoggedIn>(_loggedIn),
  TypedReducer<AuthState, AuthLoggedOut>(_loggedOut),
  TypedReducer<AuthState, AuthError>(_error),
  TypedReducer<AuthState, AuthClearError>(_clearError),
]);

AuthState _loading(AuthState authState, AuthLoading action) {
  return authState.copyWith(isLoading: true, error: null);
}

AuthState _update(AuthState authState, AuthUpdate action) {
  final token = action.token ?? authState.token ?? '';
  return authState.copyWith(
    user: action.user ?? authState.user,
    token: token,
    hasToken: token.isNotEmpty,
    isLoading: action.isLoading ?? authState.isLoading,
  );
}

AuthState _loggedIn(AuthState authState, AuthLoggedIn action) {
  return authState.copyWith(
    user: action.user ?? null,
    token: action.token,
    hasToken: action.token.isNotEmpty,
    isLoading: false,
    error: null,
  );
}

AuthState _loggedOut(AuthState authState, AuthLoggedOut action) {
  return authState.copyWith(
    user: null,
    token: '',
    hasToken: false,
    isLoading: false,
    error: null,
  );
}

AuthState _error(AuthState authState, AuthError action) {
  return authState.copyWith(
    isLoading: false,
    error: action.error,
  );
}

AuthState _clearError(AuthState authState, AuthClearError action) {
  return authState.copyWith(
    isLoading: false,
    error: null,
  );
}
