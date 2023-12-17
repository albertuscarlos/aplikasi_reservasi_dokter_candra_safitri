part of 'reservasi_anda_bloc.dart';

@immutable
sealed class ReservasiAndaState {}

final class ReservasiAndaInitial extends ReservasiAndaState {}

final class ReservasiAndaLoading extends ReservasiAndaState {}

final class ReservasiAndaSuccess extends ReservasiAndaState {
  final List<ReservasiAndaData> reservasi;

  ReservasiAndaSuccess({required this.reservasi});
}

final class ReservasiAndaFailed extends ReservasiAndaState {
  final String err;

  ReservasiAndaFailed({required this.err});
}
