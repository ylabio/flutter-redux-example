import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux_example/src/utils/app_errors.dart';

@immutable
class SnackbarState {
  final SnackBar snackBar;
  final Function action;
  final Function callback;
  final bool show;
  final AppBaseError error;

  const SnackbarState(
      {this.snackBar, this.action, this.callback, this.show, this.error});

  factory SnackbarState.initial() {
    return SnackbarState(
      snackBar: null,
      action: null,
      callback: null,
      show: false,
      error: null,
    );
  }

  SnackbarState copyWith({
    SnackBar snackBar,
    Function action,
    Function callback,
    bool show,
    AppBaseError error,
  }) {
    return SnackbarState(
      snackBar: snackBar ?? this.snackBar,
      action: action ?? this.action,
      callback: callback ?? this.callback,
      show: show ?? this.show,
      error: error,
    );
  }

  @override
  int get hashCode =>
      snackBar.hashCode ^
      action.hashCode ^
      callback.hashCode ^
      show.hashCode ^
      error.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackbarState &&
          runtimeType == other.runtimeType &&
          snackBar == other.snackBar &&
          action == other.action &&
          callback == other.callback &&
          show == other.show &&
          error == other.error;

  @override
  String toString() {
    return 'SnackbarState{snackBar: $snackBar, action: $action, callback: $callback, show: $show, error: $error}';
  }
}
