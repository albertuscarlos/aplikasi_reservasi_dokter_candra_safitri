part of 'reservasi_by_id_bloc.dart';

@immutable
sealed class ReservasiByIdEvent {}

final class LoadReservasiById extends ReservasiByIdEvent {
  final String idPasien;

  LoadReservasiById({required this.idPasien});
}
