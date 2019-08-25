import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

import 'package:flutter_redux_example/src/utils/app_errors.dart';
import 'package:flutter_redux_example/src/utils/app_settings.dart';

class BaseApiProvider {
  Dio dio;
  String token = '';
  final _options = BaseOptions(
    receiveTimeout: AppSettings.receiveTimeout,
    connectTimeout: AppSettings.connectTimeout,
  );

  static final BaseApiProvider _singleton = BaseApiProvider._internal();

  factory BaseApiProvider() => _singleton;

  BaseApiProvider._internal();

  BaseApiProvider.init(Store store) : assert(store != null) {
    token = store.state.auth.token;

    dio = Dio(_options);
    dio.interceptors.add(authInterceptor());
    dio.interceptors.add(logger);

    store.onChange.listen((state) {
      final nextToken = store.state.auth.token;
      if (nextToken != token) {
        if (nextToken == null) {
          token = '';
        } else {
          token = nextToken;
        }
      }
    });
  }

  AppBaseError errorHandler(DioError error, StackTrace stack) {
    if (error.response.statusCode == 403) {
      return AuthError.invalidSession;
    }

    return NetworkError.unknown(
        error.response.statusCode, error.response.statusMessage, stack)
      ..report();
  }

  InterceptorsWrapper authInterceptor() {
    return InterceptorsWrapper(onRequest: (options) {
      if (token.isEmpty) {
        return options;
      }

      options.headers['Authorization'] = 'Bearer $token';

      return options;
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
    print('<-- END RESPONSE');
    return response;
  }, onError: (e) {
    print(e.message);
    return e;
  });
}
