import 'package:bloc_testing/features/companylist/domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({
    required super.id,
    required super.name,
    required super.address,
    required super.zip,
    required super.country,
    required super.employeeCount,
    required super.marketCap,
    required super.domain,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      zip: json['zip'] ?? "",
      country: json['country'] ?? "",
      employeeCount: json['employee_count'] ?? "",
      marketCap: json['market_ket'] ?? "",
      domain: json['domain'] ?? "",
    );
  }
}
