part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

final class PostSignupEvent extends SignupEvent {
  final SignUpBody body;

  PostSignupEvent({required this.body});
}
