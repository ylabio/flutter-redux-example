import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:flutter_redux_example/src/models/user_model.dart';
import 'package:flutter_redux_example/src/store/app_state.dart';

abstract class AuthAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class AuthLoading extends AuthAction {}

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
