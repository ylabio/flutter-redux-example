import 'package:flutter/material.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

abstract class SnackbarAction {
  @override
  String toString() {
    return '$runtimeType';
  }
}

class SnackbarShow extends SnackbarAction {
  final SnackBar snackBar;
  final Function action;
  final Function callback;

  SnackbarShow({this.snackBar, this.action, this.callback});
}

class SnackbarHide extends SnackbarAction {}

class SnackbarError extends SnackbarAction {
  final AppBaseError error;

  SnackbarError({this.error});
}

class SnackbarClearError extends SnackbarAction {}
