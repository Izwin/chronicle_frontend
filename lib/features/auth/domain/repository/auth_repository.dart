import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/auth/domain/model/user_model.dart';

abstract class AuthRepository{
  Future<Either<Failure,UserModel>> loginWithGoogle();
  Future<Either<Failure,void>> logout();
}