import 'package:bloc/bloc.dart';
import 'package:bloc_testing/core/constant/constant.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:bloc_testing/features/auth/domain/usercase/auth_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc(this.authUsecase) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginRequested) {
        await _handleLogin(event, emit);
      } else if (event is LogoutRequested) {
        await _handleLogout(emit);
      }
    });
  }

  _handleLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authUsecase.login(event.email, event.password);

    debugPrint("Login response: ${result}");
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
