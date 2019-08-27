import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_redux_example/src/utils/preferences_key.dart';

class AuthStorageProvider {
  final SharedPreferences _prefs;

  AuthStorageProvider(this._prefs);

  String getToken() {
    return _prefs.getString(PreferencesKey.authToken);
  }

  Future<bool> setToken(String token) async {
    return await _prefs.setString(PreferencesKey.authToken, token);
  }

  Future<bool> removeToken() async {
    return await _prefs.remove(PreferencesKey.authToken);
  }
}
