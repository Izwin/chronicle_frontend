import 'package:chronicle/features/auth/domain/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource({required this.dio});

  Future<UserModel> loginWithGoogle(String token) async {
    var request = await dio.post('users/login', data: {'token': token});
    return UserModel.fromJson(request.data);
  }
}
