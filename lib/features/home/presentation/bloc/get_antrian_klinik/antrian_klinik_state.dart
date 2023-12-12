part of 'antrian_klinik_bloc.dart';

@immutable
sealed class AntrianKlinikState {}

final class AntrianKlinikInitial extends AntrianKlinikState {}

final class AntrianKlinikLoading extends AntrianKlinikState {}

final class AntrianKlinikSuccess extends AntrianKlinikState {
  final List<AntrianKlinikData> antrianKlinik;

  AntrianKlinikSuccess({required this.antrianKlinik});
}

final class AntrianKlinikFailed extends AntrianKlinikState {
  final String error;

  AntrianKlinikFailed({required this.error});
}
