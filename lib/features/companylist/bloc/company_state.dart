part of 'company_bloc.dart';

@immutable
sealed class CompanyState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CompanyInitial extends CompanyState {}

final class CompanyLoading extends CompanyState {}

final class CompanyLoadSuccess extends CompanyState {
  final List<Company> companies;
  CompanyLoadSuccess({required this.companies});

  @override
  List<Object?> get props => [companies];
}

final class CompanyFailure extends CompanyState {
  final String error;

  CompanyFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
