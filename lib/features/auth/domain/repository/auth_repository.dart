import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<String, User>> login(String email, String password);
  Future<Either<String, void>> logout();
}
