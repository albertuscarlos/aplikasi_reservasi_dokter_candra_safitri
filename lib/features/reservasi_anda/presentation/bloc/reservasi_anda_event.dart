part of 'reservasi_anda_bloc.dart';

@immutable
sealed class ReservasiAndaEvent {}

final class LoadReservasiAnda extends ReservasiAndaEvent {
  final String idPasien;

  LoadReservasiAnda({required this.idPasien});
}
