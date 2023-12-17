part of 'delete_reservasi_bloc.dart';

@immutable
sealed class DeleteReservasiEvent {}

final class DeleteReservasi extends DeleteReservasiEvent {
  final String idReservasi;

  DeleteReservasi({required this.idReservasi});
}
