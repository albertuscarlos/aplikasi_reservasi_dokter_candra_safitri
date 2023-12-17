part of 'riwayat_reservasi_bloc.dart';

@immutable
sealed class RiwayatReservasiEvent {}

final class LoadRiwayatReservasi extends RiwayatReservasiEvent {
  LoadRiwayatReservasi({
    required this.idPasien,
  });

  final String idPasien;
}
