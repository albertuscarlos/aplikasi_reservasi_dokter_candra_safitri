part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class PostLoginEvent extends LoginEvent {
  final LoginBody body;

  PostLoginEvent({required this.body});
}
