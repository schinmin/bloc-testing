import 'package:bloc_testing/core/constant/constant.dart';
import 'package:bloc_testing/core/network/api_client.dart';
import 'package:bloc_testing/features/auth/data/models/user_model.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class HomeRepository {
  Future<Either<String, User>> fetchData(int userId);
}

class HomeRepositoryImpl extends HomeRepository {
  final ApiClient apiClient = ApiClient();
  HomeRepositoryImpl();

  @override
  Future<Either<String, User>> fetchData(int userId) async {
    final Dio dio = Dio();
    try {
      final response = await dio.get('${ApiConstants.baseUrl}/users/$userId');

      debugPrint('Fetch data response: ${response.data}');

      if (response.statusCode! <= 300) {
        final data = response.data;
        final user = UserModel.fromJson(data);
        return Right(user);
      } else {
        return Left(
          'Failed to fetch data with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Error : $e");
      return Left("Failed to fetch data");
    }
    // Simulate fetching data from an API or database
  }
}
