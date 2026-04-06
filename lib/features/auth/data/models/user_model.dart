import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';

class UserModel extends User {
  UserModel({
    required int id,
    required String company,
    required String address,
    required String name,
    required String email,
    String? token,
  }) : super(
         id: id,
         company: company,
         address: address,
         name: name,
         email: email,
         token: token,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      company: json['company'],
      address: json['address'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
