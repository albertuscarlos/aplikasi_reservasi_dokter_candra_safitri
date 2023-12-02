part of 'obscure_password_cubit.dart';

@immutable
sealed class ObscurePasswordState {}

final class ObscurePasswordInitial extends ObscurePasswordState {}

final class ObscurePasswordOn extends ObscurePasswordState {}

final class ObscurePasswordOff extends ObscurePasswordState {}
