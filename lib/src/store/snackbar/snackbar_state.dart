import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux_example/src/utils/app_errors.dart';

@immutable
class SnackbarState {
  final BuildContext context;
  final SnackBar snackBar;
  final Function callback;
  final bool show;
  final AppBaseError error;

  const SnackbarState(
      {this.context, this.snackBar, this.callback, this.show, this.error});

  factory SnackbarState.initial() {
    return SnackbarState(
      context: null,
      snackBar: null,
      callback: null,
      show: false,
      error: null,
    );
  }

  SnackbarState copyWith({
    BuildContext context,
    SnackBar snackBar,
    Function action,
    Function callback,
    bool show,
    AppBaseError error,
  }) {
    return SnackbarState(
      context: context ?? this.context,
      snackBar: snackBar ?? this.snackBar,
      callback: callback ?? this.callback,
      show: show ?? this.show,
      error: error,
    );
  }

  @override
  int get hashCode =>
      context.hashCode ^
      snackBar.hashCode ^
      callback.hashCode ^
      show.hashCode ^
      error.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackbarState &&
          runtimeType == other.runtimeType &&
          context == other.context &&
          snackBar == other.snackBar &&
          callback == other.callback &&
          show == other.show &&
          error == other.error;

  @override
  String toString() {
    return 'SnackbarState{snackBar: $snackBar, callback: $callback, show: $show, error: $error}';
  }
}
