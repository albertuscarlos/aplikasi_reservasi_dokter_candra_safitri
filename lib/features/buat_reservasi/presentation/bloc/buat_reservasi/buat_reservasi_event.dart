part of 'buat_reservasi_bloc.dart';

@immutable
sealed class BuatReservasiEvent {}

final class CreateReservasi extends BuatReservasiEvent {
  final PostReservasiBody body;

  CreateReservasi({required this.body});
}
