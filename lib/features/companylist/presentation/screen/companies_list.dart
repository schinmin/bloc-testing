import 'package:bloc_testing/features/companylist/bloc/company_bloc.dart';
import 'package:bloc_testing/features/companylist/presentation/screen/company_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  @override
  void initState() {
    super.initState();

    context.read<CompanyBloc>().add(GetCompanies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Companies List")),

      body: BlocConsumer<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return Center(child: const CircularProgressIndicator());
          }
          return state is CompanyLoadSuccess
              ? ListView.builder(
                  itemCount: state.companies.length,
                  itemBuilder: (context, index) {
                    final company = state.companies[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CompanyDetail(company: company),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(company.name),
                          trailing: Text(company.country),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: Text("No data "));
        },
        listener: (context, state) {
          if (state is CompanyFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
      ),
    );
  }
}
