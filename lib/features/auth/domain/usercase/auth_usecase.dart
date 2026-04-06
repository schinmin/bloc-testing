import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:bloc_testing/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase(this.authRepository);
  Future<Either<String, User>> login(String email, String password) {
    return authRepository.login(email, password);
  }

  Future<Either<String, void>> logout() {
    return authRepository.logout();
  }
}
