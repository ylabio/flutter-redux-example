import 'package:dio/dio.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_redux_example/src/utils/app_settings.dart';
import 'package:flutter_redux_example/src/utils/preferences_key.dart';

class Http {
  Dio dio;
  String token = '';
  SharedPreferences _prefs;
  final _options = BaseOptions(
    receiveTimeout: AppSettings.receiveTimeout,
    connectTimeout: AppSettings.connectTimeout,
  );

  static final Http _singleton = Http._internal();

  factory Http() => _singleton;

  Http._internal();

  void init(Store store, SharedPreferences prefs) {
    assert(store != null && prefs != null);

    _prefs = prefs;
    token = _prefs.getString(PreferencesKey.authToken) ?? '';

    dio = Dio(_options);
    dio.interceptors.add(_authInterceptor());
    dio.interceptors.add(logger);

    store.onChange.listen((state) {
      final nextToken = store.state.authState.token;
      if (nextToken != token) {
        if (nextToken == null) {
          token = '';
        } else {
          token = nextToken;
        }
      }
    });
  }

  final InterceptorsWrapper logger = InterceptorsWrapper(onRequest: (options) {
    print('-- REQUEST --');
    print('--> ${options.method} ${options.path}');
    print('Content type: ${options.contentType}');
    return options;
  }, onResponse: (response) {
    print('-- RESPONSE --');
    print(
        '<-- ${response.statusCode} ${response.request.method} ${response.request.path}');
    print(response.data);
    print('-- END RESPONSE --');
    return response;
  }, onError: (e) {
    print(e.message);
    return e;
  });

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(onRequest: (options) {
      if ((token ?? '').isEmpty) {
        return options;
      }
      options.headers['X-Token'] = token;
      return options;
    });
  }
}
