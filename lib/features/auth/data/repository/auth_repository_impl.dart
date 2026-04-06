import 'package:bloc_testing/features/auth/data/resources/auth_dataresource.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:bloc_testing/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataresource authDataresource;
  AuthRepositoryImpl(this.authDataresource);

  @override
  Future<Either<String, User>> login(String email, String password) {
    // Implementation for login
    if (email.isEmpty || password.isEmpty) {
      return Future.value(Left('Email and password cannot be empty'));
    }
    return authDataresource.login(email, password).then((response) {
      if (response.token != null) {
        final user = User(
          id: response.id,
          company: response.company,
          address: response.address,
          name: response.name,
          email: response.email,

          token: response.token,
        );
        return Right(user);
      } else {
        return Left('Login failed with status code: ${response}');
      }
    });
  }

  @override
  Future<Either<String, void>> logout() {
    return authDataresource.logout().then((response) {
      if (response.token == null) {
        return Right(null);
      } else {
        return Left('Logout failed with status code: ${response}');
      }
    });
    // Implementation for logout
  }
}
