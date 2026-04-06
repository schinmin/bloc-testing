import 'package:bloc_testing/core/network/api_client.dart';
import 'package:bloc_testing/features/auth/bloc/auth_bloc.dart';
import 'package:bloc_testing/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bloc_testing/features/auth/data/resources/auth_dataresource.dart';
import 'package:bloc_testing/features/auth/domain/usercase/auth_usecase.dart';
import 'package:bloc_testing/features/companylist/bloc/company_bloc.dart';
import 'package:bloc_testing/features/companylist/domain/repository/company_repository.dart';
import 'package:bloc_testing/features/companylist/presentation/screen/companies_list.dart';
import 'package:bloc_testing/features/home/bloc/home_bloc.dart';
import 'package:bloc_testing/features/home/domain/repository/home_repository.dart';
import 'package:bloc_testing/features/home/presentation/screens/splash_screen.dart';
import 'package:bloc_testing/features/userlist/bloc/userlist_bloc.dart';
import 'package:bloc_testing/features/userlist/domain/repository/user_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CompanyBloc(CompanyRepositoryImpl()),
          child: CompaniesList(),
        ),
        BlocProvider(
          create: (_) => UserlistBloc(UserListRepositoryImpl()),
        ), // Add your bloc providers here
        BlocProvider(create: (_) => HomeBloc(HomeRepositoryImpl())),
        BlocProvider(
          create: (_) => AuthBloc(
            AuthUsecase(AuthRepositoryImpl(AuthDataresource(ApiClient()))),
          ),
        ), // Add your bloc providers here
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Testing',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const SplashScreen(),
      ),
    );
  }
}
