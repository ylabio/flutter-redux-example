import 'package:meta/meta.dart';

import 'auth/auth_state.dart';

@immutable
class AppState {
  final AuthState authState;

  const AppState({
    @required this.authState,
  });

  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
    );
  }

  AppState copyWith({AuthState authState}) {
    return AppState(
      authState: authState ?? this.authState,
    );
  }
}
