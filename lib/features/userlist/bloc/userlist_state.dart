part of 'userlist_bloc.dart';

@immutable
sealed class UserlistState {}

final class UserlistInitial extends UserlistState {}

final class UserlistLoading extends UserlistState {}

final class UserlistSuccess extends UserlistState {
  final List<User> users;
  UserlistSuccess(this.users);
}

final class UserlistFailure extends UserlistState {
  final String error;
  UserlistFailure(this.error);
}
