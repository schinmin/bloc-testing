part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchHomeData extends HomeEvent {
  final int userId;
  FetchHomeData(this.userId);
}
