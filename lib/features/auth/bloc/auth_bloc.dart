import 'package:bloc/bloc.dart';
import 'package:bloc_testing/core/constant/constant.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:bloc_testing/features/auth/domain/usercase/auth_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc(this.authUsecase) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is LoginRequested) {
        _handleLogin(event, emit);
      } else if (event is LogoutRequested) {
        _handleLogout(emit);
      }
    });
  }

  _handleLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Dio dio = Dio();
    final result = await authUsecase.login(event.email, event.password);
    final response = await dio.post(
      ApiConstants.loginEndpoint,
      data: {'email': event.email, 'password': event.password},
    );
    debugPrint("Login response: ${response.data}");
    result.fold(
      (failure) => emit(AuthFailure(failure)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  _handleLogout(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUsecase.logout();
    result.fold(
      (failure) => emit(AuthFailure(failure)),
      (_) => emit(AuthInitial()),
    );
  }
}
