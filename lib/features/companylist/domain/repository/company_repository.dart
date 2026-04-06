import 'package:bloc_testing/core/constant/constant.dart';
import 'package:bloc_testing/features/companylist/data/models/company_model.dart';
import 'package:bloc_testing/features/companylist/domain/entities/company.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class CompanyRepository {
  Future<Either<String, List<Company>>> fetchCompany();
}

class CompanyRepositoryImpl extends CompanyRepository {
  @override
  Future<Either<String, List<Company>>> fetchCompany() async {
    final Dio dio = Dio();

    try {
      final result = await dio.get("${ApiConstants.baseUrl}/companies");

      debugPrint("Response : ${result.data}");

      if (result.statusCode == 200) {
        List<CompanyModel> companies = (result.data as List)
            .map((company) => CompanyModel.fromJson(company))
            .toList();
        debugPrint("Companies : $companies");
        return Right(companies);
      } else {
        return Left("Error : ${result.data['message']}");
      }
    } catch (e) {
      return Left("Error :${e.toString()} ");
    }
  }
}

// class CompanyRepositoryImpl extends CompanyRepository {
//   @override
//   Future<Either<String, List<Company>>> fetchCompany() async {
//     final Dio dio = Dio();

//     try {
//       final result = await dio.get("${ApiConstants.baseUrl}/companies");

//       debugPrint("Response : ${result.data}");

//       if (result.statusCode == 200) {
//         List<CompanyModel> companies = (result.data as List)
//             .map((company) => CompanyModel.fromJson(company))
//             .toList();

//         return Right(companies);
//       } else {
//         return Left("Server Error");
//       }
//     } catch (e) {
//       return Left("Error: ${e.toString()}");
//     }
//   }
// }
