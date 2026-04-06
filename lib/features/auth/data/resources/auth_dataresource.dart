import 'dart:math';

import 'package:bloc_testing/core/constant/constant.dart';
import 'package:bloc_testing/core/network/api_client.dart';
import 'package:bloc_testing/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthDataresource {
  ApiClient apiClient;
  AuthDataresource(this.apiClient);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        ApiConstants.loginEndpoint,
        data: {'email': email, 'password': password},
      );
      debugPrint('Login response: ${response.data}');
      return UserModel(
        id: response.data['id'] ?? 0,
        company: response.data['company'] ?? "",
        address: response.data['address'] ?? "",
        email: email,
        name: 'John Doe',
        token: response.data['token'] ?? "",
      );
    } catch (e) {
      debugPrint('Login failed: $e');
      rethrow;
    }
  }

  Future<UserModel> logout() async {
    try {
      final response = await apiClient.dio.post('/logout');
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
