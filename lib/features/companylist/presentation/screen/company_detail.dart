import 'package:bloc_testing/features/companylist/domain/entities/company.dart';
import 'package:flutter/material.dart';

class CompanyDetail extends StatelessWidget {
  final Company company;
  const CompanyDetail({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Card(
          child: Center(
            child: Column(
              children: [
                ClipOval(
                  child: CircleAvatar(radius: 30, child: Icon(Icons.home)),
                ),
                Text(company.name),
                ListTile(
                  title: Text("Address"),
                  subtitle: Text(company.address),
                  trailing: Text(company.country),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
