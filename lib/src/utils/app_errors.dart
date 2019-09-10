import 'app_logger.dart';

class AppBaseError {
  final int code;
  final String description;
  final StackTrace stack;

  AppBaseError({
    this.code = 1000,
    this.description = '',
    this.stack,
  });

  void report() {
    AppLogger().error(this);
  }

  @override
  String toString() {
    return '$code: $description';
  }
}

class AuthError {
  static final AppBaseError invalidSession =
      AppBaseError(description: 'Invalid authorization token');

  static final AppBaseError loginFailed =
      AppBaseError(description: 'Wrong login or password');
}

class ValidationError {
  ValidationError._();

  static final AppBaseError loginEmpty =
      AppBaseError(description: 'Login is empty');

  static final AppBaseError passwordEmpty =
      AppBaseError(description: 'Password is empty');
}

class NetworkError {
  static AppBaseError unknown(int code, String description, StackTrace stack) =>
      AppBaseError(code: code, description: description, stack: stack);
}
