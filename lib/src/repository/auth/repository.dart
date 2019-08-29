import 'package:meta/meta.dart';

import 'package:flutter_redux_example/src/models/auth_response.dart';
import 'auth_api_provider.dart';
import 'auth_storage_provider.dart';

class AuthRepository {
  final AuthApiProvider _apiProvider;
  final AuthStorageProvider _storageProvider;

  AuthRepository(this._storageProvider, this._apiProvider);

  AuthApiProvider get apiProvider => _apiProvider;

  Future<AuthResponse> login({
    @required String login,
    @required String password,
  }) async {
    return await _apiProvider.login(login: login, password: password);
  }

  Future<AuthResponse> logout() async {
    return await _apiProvider.logout();
  }

  Future<AuthResponse> profile() async {
    return await _apiProvider.profile();
  }

  String getToken() {
    return _storageProvider.getToken();
  }

  Future<bool> setToken(String token) async {
    return await _storageProvider.setToken(token);
  }

  Future<bool> removeToken() async {
    return await _storageProvider.removeToken();
  }

  bool hasToken() {
    final token = getToken();

    if (token == null || token.isEmpty) {
      return false;
    }

    return true;
  }
}
