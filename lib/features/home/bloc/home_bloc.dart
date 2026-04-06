import 'package:bloc/bloc.dart';
import 'package:bloc_testing/features/auth/domain/entites/user_entity.dart';
import 'package:bloc_testing/features/home/domain/repository/home_repository.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is FetchHomeData) {
        emit(HomeLoading());
        await homeRepository.fetchData(event.userId).then((result) {
          debugPrint("Home data fetched for userId: ${event.userId}");
          result.fold(
            (failure) => emit(HomeFailure(failure)),
            (user) => emit(HomeSuccess(user)),
          );
        });
      }
    });
  }
}
