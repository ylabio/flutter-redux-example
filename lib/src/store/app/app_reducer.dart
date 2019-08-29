import 'app_state.dart';
import 'package:flutter_redux_example/src/store/auth/auth_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) => AppState(
      authState: authStateReducer(state.authState, action),
    );
