import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:flutter_redux_example/src/models/user_model.dart';
import 'package:flutter_redux_example/src/repository/auth/repository.dart';
import 'package:flutter_redux_example/src/store/app_state.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

abstract class AuthAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class AuthLoading extends AuthAction {}

class AuthLoaded extends AuthAction {}

class AuthLoggedIn extends AuthAction {
  final String token;
  final User user;

  AuthLoggedIn({@required this.token, this.user}) : assert(token != null);
}

class AuthLoggedOut extends AuthAction {}

class AuthSetUser extends AuthAction {
  final User user;

  AuthSetUser(this.user);
}

class AuthError extends AuthAction {
  final AppBaseError error;

  AuthError({this.error});
}

class AuthClearError extends AuthAction {}

ThunkAction<AppState> remind(context) {
  final authRepository = Provider.of<AuthRepository>(context);
  return (Store<AppState> store) async {
    store.dispatch(AuthLoading());

    if (authRepository.hasToken()) {
      store.dispatch(AuthLoggedIn(token: authRepository.getToken()));
      return;
    }

    store.dispatch(AuthLoaded());
  };
}

ThunkAction<AppState> signin(context, String login, String password) {
  final authRepository = Provider.of<AuthRepository>(context);
  return (Store<AppState> store) async {
    store.dispatch(AuthLoading());

    final authResponse =
        await authRepository.login(login: login, password: password);

    if (authResponse.error != null) {
      store.dispatch(AuthError(error: authResponse.error));
      return;
    }

    await authRepository.setToken(authResponse.token);

    store.dispatch(
        AuthLoggedIn(token: authResponse.token, user: authResponse.user));
  };
}

ThunkAction<AppState> signout(context) {
  final authRepository = Provider.of<AuthRepository>(context);
  return (Store<AppState> store) async {
    store.dispatch(AuthLoading());

    await authRepository.logout();
    await authRepository.removeToken();

    store.dispatch(AuthLoggedOut());
  };
}
