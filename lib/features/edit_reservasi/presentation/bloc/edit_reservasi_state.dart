part of 'edit_reservasi_bloc.dart';

@immutable
sealed class EditReservasiState {}

final class EditReservasiInitial extends EditReservasiState {}

final class EditReservasiLoading extends EditReservasiState {}

final class EditReservasiSucces extends EditReservasiState {}

final class EditReservasiFailed extends EditReservasiState {}
