import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TokenInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    try {
      User? currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        String? token = await currentUser.getIdToken(true);

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }

      handler.next(options);
    } catch (e) {
      handler.reject(
          DioException(
              requestOptions: options, error: 'Failed to retrieve token'),
          true);
    }
  }

  @override
  Future<void> onError(DioException err,
      ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        User? currentUser = _firebaseAuth.currentUser;

        if (currentUser != null) {
          String? newToken = await currentUser.getIdToken(true);

          if (newToken != null) {
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          }

          final response = await dio.request(err.requestOptions.path,
              options: Options(method: err.requestOptions.method,
                  headers: err.requestOptions.headers),
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters);

          return handler.resolve(response);
        }
      }
      catch (e) {
        return handler.next(err);
      }
    }
    handler.next(err);
  }
}
