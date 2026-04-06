import 'package:bloc_testing/core/constant/constant.dart';
import 'package:bloc_testing/features/auth/data/models/user_model.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class UserListRepository {
  Future<Either<String, List<User>>> fetchUserList(int page);
}

class UserListRepositoryImpl extends UserListRepository {
  @override
  Future<Either<String, List<User>>> fetchUserList(int page) async {
    final Dio dio = Dio();

    try {
      final response = await dio.get("${ApiConstants.baseUrl}/users");

      if (response.statusCode! <= 300) {
        final data = response.data as List;
        final users = data.map((json) => UserModel.fromJson(json)).toList();
        return Right(users);
      } else {
        return Left(
          'Failed to fetch user list with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Error $e");
      return Left("Failed to fetch user list");
    }
    // Simulate fetching user list from an API or database
  }
}
