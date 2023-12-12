part of 'pref_bloc.dart';

@immutable
sealed class PrefState {}

final class PrefInitial extends PrefState {}

final class PrefLoading extends PrefState {}

final class PrefSuccess extends PrefState {
  final String namaPasien;
  final String idPasien;

  PrefSuccess({required this.namaPasien, required this.idPasien});
}

final class PrefFailure extends PrefState {}
