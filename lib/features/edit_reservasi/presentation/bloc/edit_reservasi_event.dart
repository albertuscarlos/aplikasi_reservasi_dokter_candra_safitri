part of 'edit_reservasi_bloc.dart';

@immutable
sealed class EditReservasiEvent {}

final class EditReservasi extends EditReservasiEvent {
  EditReservasi({required this.body, required this.idReservasi});

  final EditReservasiBody body;
  final String idReservasi;
}
