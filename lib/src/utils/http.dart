import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_example/src/utils/app_settings.dart';

class Http {
  Dio dio;
  String token = '';
  final _options = BaseOptions(
    receiveTimeout: AppSettings.receiveTimeout,
    connectTimeout: AppSettings.connectTimeout,
  );

  static final Http _singleton = Http._internal();

  factory Http() => _singleton;

  Http._internal();

  void init(Store store) {
    assert(store != null);
    token = store.state.authState.token;

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
