part of 'company_bloc.dart';

@immutable
sealed class CompanyEvent {}

class GetCompanies extends CompanyEvent {}
