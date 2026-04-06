part of 'userlist_bloc.dart';

@immutable
sealed class UserlistEvent {}

class FetchUserlist extends UserlistEvent {
  final int page;
  FetchUserlist(this.page);
}
