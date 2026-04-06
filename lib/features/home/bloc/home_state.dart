part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final User user;
  HomeSuccess(this.user);
}

final class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}
