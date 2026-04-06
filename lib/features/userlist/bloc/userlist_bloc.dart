import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:bloc_testing/features/userlist/domain/repository/user_list_repository.dart';
import 'package:flutter/material.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserlistBloc extends Bloc<UserlistEvent, UserlistState> {
  final UserListRepository userListRepository;
  UserlistBloc(this.userListRepository) : super(UserlistInitial()) {
    on<UserlistEvent>((event, emit) async {
      if (event is FetchUserlist) {
        emit(UserlistLoading());

        await userListRepository.fetchUserList(event.page).then((result) {
          debugPrint("User list fetched for page: ${event.page}");
          result.fold(
            (failure) => emit(UserlistFailure(failure)),
            (users) => emit(UserlistSuccess(users)),
          );
        });
      }
    });
  }
}
