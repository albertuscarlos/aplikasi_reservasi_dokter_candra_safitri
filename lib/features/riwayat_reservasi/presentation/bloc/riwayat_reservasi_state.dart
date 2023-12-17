part of 'riwayat_reservasi_bloc.dart';

@immutable
sealed class RiwayatReservasiState {}

final class RiwayatReservasiInitial extends RiwayatReservasiState {}

final class RiwayatReservasiLoading extends RiwayatReservasiState {}

final class RiwayatReservasiSuccess extends RiwayatReservasiState {
  RiwayatReservasiSuccess({
    required this.riwayatReservasi,
  });

  final List<RiwayatReservasiData>? riwayatReservasi;
}

final class RiwayatReservasiFailed extends RiwayatReservasiState {}
