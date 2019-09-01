import 'package:flutter_redux_example/src/models/user_model.dart';
import 'package:flutter_redux_example/src/utils/app_errors.dart';

class UserResponse {
  final User user;
  final AppBaseError error;

  UserResponse(this.user, this.error);

  UserResponse.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json),
        error = null;

  UserResponse.withError(this.error) : user = null;
}
