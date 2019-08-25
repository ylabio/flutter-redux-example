import 'package:meta/meta.dart';

import 'package:flutter_redux_example/src/models/user_model.dart';

@immutable
class AuthState {
  final User user;
  final String token;
  final bool hasToken;
  final bool isLoading;

  const AuthState({this.user, this.token, this.hasToken, this.isLoading});

  factory AuthState.initial() {
    return AuthState(
      user: null,
      token: '',
      hasToken: false,
      isLoading: false,
    );
  }

  AuthState copyWith({
    User user,
    String token,
    bool hasToken,
    bool isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      hasToken: hasToken ?? this.hasToken,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  int get hashCode =>
      user.hashCode ^ token.hashCode ^ hasToken.hashCode ^ isLoading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          token == other.token &&
          hasToken == other.hasToken &&
          isLoading == other.isLoading;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'AuthState{user: $user, token: $token, hasToken: $hasToken, isLoading: $isLoading}';
  }
}
