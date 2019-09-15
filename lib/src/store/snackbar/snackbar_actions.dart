import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux_example/src/utils/app_errors.dart';
import 'package:flutter_redux_example/src/store/app/app_state.dart';

abstract class SnackbarAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class SnackbarShow extends SnackbarAction {
  final BuildContext context;
  final SnackBar snackBar;
  final Function callback;

  SnackbarShow(
      {@required this.context, @required this.snackBar, this.callback});
}

class SnackbarHide extends SnackbarAction {}

class SnackbarError extends SnackbarAction {
  final AppBaseError error;

  SnackbarError({this.error});
}

class SnackbarClearError extends SnackbarAction {}

ThunkAction<AppState> show(context, snackBar,
    {Function action, Function callback}) {
  return (Store<AppState> store) async {
    store.dispatch(SnackbarHide());
    store.dispatch(SnackbarShow(
      context: context,
      snackBar: snackBar,
      callback: callback,
    ));
  };
}
