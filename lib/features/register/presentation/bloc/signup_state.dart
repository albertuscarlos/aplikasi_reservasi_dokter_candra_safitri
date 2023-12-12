part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final SignUpResponse response;

  SignupSuccess({required this.response});
}

final class SignupFailed extends SignupState {
  final String failedMessage;

  SignupFailed({required this.failedMessage});
}
