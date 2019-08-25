import 'app_state.dart';
import 'auth/auth_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) => AppState(
      authState: authStateReducer(state.authState, action),
    );
