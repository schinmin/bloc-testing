import 'package:bloc/bloc.dart';
import 'package:bloc_testing/features/companylist/domain/entities/company.dart';
import 'package:bloc_testing/features/companylist/domain/repository/company_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final CompanyRepository companyRepository;
  CompanyBloc(this.companyRepository) : super(CompanyInitial()) {
    on<CompanyEvent>((event, emit) async {
      if (event is GetCompanies) {
        emit(CompanyLoading());

        await companyRepository.fetchCompany().then(
          (result) => {
            result.fold(
              (failuer) => emit(CompanyFailure(error: failuer.toString())),
              (company) => emit(CompanyLoadSuccess(companies: company)),
            ),
          },
        );
      }
    });
  }
}
