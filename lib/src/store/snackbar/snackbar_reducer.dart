import 'package:redux/redux.dart';

import 'snackbar_actions.dart';
import 'snackbar_state.dart';

Reducer<SnackbarState> snackbarStateReducer = combineReducers<SnackbarState>([
  TypedReducer<SnackbarState, SnackbarShow>(_show),
  TypedReducer<SnackbarState, SnackbarHide>(_hide),
  TypedReducer<SnackbarState, SnackbarError>(_error),
  TypedReducer<SnackbarState, SnackbarClearError>(_clearError),
]);

SnackbarState _show(SnackbarState snackbarState, SnackbarShow action) {
  return snackbarState.copyWith(
    context: action.context,
    snackBar: action.snackBar,
    callback: action.callback,
    show: true,
    error: null,
  );
}

SnackbarState _hide(SnackbarState snackbarState, SnackbarHide action) {
  return snackbarState.copyWith(context: null, show: false, error: null);
}

SnackbarState _error(SnackbarState snackbarState, SnackbarError action) {
  return snackbarState.copyWith(error: action.error);
}

SnackbarState _clearError(
    SnackbarState snackbarState, SnackbarClearError action) {
  return snackbarState.copyWith(error: null);
}
