part of 'delete_reservasi_bloc.dart';

@immutable
sealed class DeleteReservasiState {}

final class DeleteReservasiInitial extends DeleteReservasiState {}

final class DeleteReservasiLoading extends DeleteReservasiState {}

final class DeleteReservasiSuccess extends DeleteReservasiState {}

final class DeleteReservasiFailed extends DeleteReservasiState {}
