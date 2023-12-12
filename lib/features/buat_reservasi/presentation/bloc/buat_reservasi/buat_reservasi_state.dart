part of 'buat_reservasi_bloc.dart';

@immutable
sealed class BuatReservasiState {}

final class BuatReservasiInitial extends BuatReservasiState {}

final class BuatReservasiLoading extends BuatReservasiState {}

final class BuatReservasiSuccess extends BuatReservasiState {}

final class BuatReservasiFailed extends BuatReservasiState {}
