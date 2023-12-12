part of 'reservasi_by_id_bloc.dart';

@immutable
sealed class ReservasiByIdState {}

final class ReservasiByIdInitial extends ReservasiByIdState {}

final class ReservasiLoading extends ReservasiByIdState {}

final class ReservasiSuccess extends ReservasiByIdState {
  final List<ReservasiData>? reservasiById;
  final String? message;

  ReservasiSuccess({this.reservasiById, this.message});
}

final class ReservasiFailed extends ReservasiByIdState {
  final String errorMessage;

  ReservasiFailed({required this.errorMessage});
}
