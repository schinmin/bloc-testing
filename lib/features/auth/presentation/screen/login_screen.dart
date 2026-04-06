import 'package:bloc_testing/features/auth/bloc/auth_bloc.dart';
import 'package:bloc_testing/features/auth/presentation/widgets/form_widget.dart';
import 'package:bloc_testing/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Welcome ${state.user.name}')),
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (context) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthFailure) {
            return Center(child: Text(state.error));
          } else if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return Center(child: Text('Welcome ${state.user.name}'));
          }

          return CusForm();
        },
      ),
    );
  }
}
