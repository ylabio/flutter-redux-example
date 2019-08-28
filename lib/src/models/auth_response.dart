import 'package:flutter_redux_example/src/models/user_model.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

class AuthResponse {
  final String token;
  final User user;
  final AppBaseError error;

  AuthResponse(this.token, this.user, this.error);

  AuthResponse.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = User.fromJson(json['user']),
        error = null;

  AuthResponse.withError(this.error)
      : token = null,
        user = null;
}
