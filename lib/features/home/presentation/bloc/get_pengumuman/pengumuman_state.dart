part of 'pengumuman_bloc.dart';

@immutable
sealed class PengumumanState {}

final class PengumumanInitial extends PengumumanState {}

final class PengumumanLoading extends PengumumanState {}

final class PengumumanSuccess extends PengumumanState {
  final PengumumanResponse pengumuman;

  PengumumanSuccess({required this.pengumuman});
}

final class PengumumanFailure extends PengumumanState {
  final String errorMessage;

  PengumumanFailure({required this.errorMessage});
}
