import 'package:meta/meta.dart';

import 'package:flutter_redux_example/src/models/user_model.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

@immutable
class AuthState {
  final User user;
  final String token;
  final bool hasToken;
  final bool isLoading;
  final AppBaseError error;

  const AuthState(
      {this.user, this.token, this.hasToken, this.isLoading, this.error});

  factory AuthState.initial() {
    return AuthState(
      user: null,
      token: null,
      hasToken: false,
      isLoading: false,
      error: null,
    );
  }

  AuthState copyWith({
    User user,
    String token,
    bool hasToken,
    bool isLoading,
    AppBaseError error,
  }) {
    return AuthState(
      user: user,
      token: token ?? this.token,
      hasToken: hasToken ?? this.hasToken,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  int get hashCode =>
      user.hashCode ^
      token.hashCode ^
      hasToken.hashCode ^
      isLoading.hashCode ^
      error.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          token == other.token &&
          hasToken == other.hasToken &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'AuthState{user: $user, token: $token, hasToken: $hasToken, isLoading: $isLoading, error: $error}';
  }
}
