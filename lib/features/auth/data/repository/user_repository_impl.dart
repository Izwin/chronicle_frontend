import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:chronicle/features/auth/domain/model/user_model.dart';
import 'package:chronicle/features/auth/domain/repository/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      return Either.right(await userRemoteDatasource.getUser());
    }
    on DioException catch (e){
      return Either.left(AuthFailure(message: e.response?.data['error']));
    }
    catch (e) {
      return Either.left(AuthFailure(message: 'Authorization error'));
    }
  }
}
