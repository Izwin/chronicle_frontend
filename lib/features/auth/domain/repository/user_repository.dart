import 'package:chronicle/core/failure/failure.dart';
import 'package:chronicle/core/model/either.dart';
import 'package:chronicle/features/auth/domain/model/user_model.dart';

abstract class UserRepository{
  Future<Either<Failure,UserModel>> getUser();
}