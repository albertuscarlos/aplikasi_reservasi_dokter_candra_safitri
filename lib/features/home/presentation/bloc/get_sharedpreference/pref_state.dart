part of 'pref_bloc.dart';

@immutable
sealed class PrefState {}

final class PrefInitial extends PrefState {}

final class PrefLoading extends PrefState {}

final class PrefSuccess extends PrefState {
  final String namaPasien;
  final String idPasien;
  final String jenisKelamin;
  final String tanggalLahir;
  final String noTelepon;
  final String fotoPasien;
  final String username;

  PrefSuccess(
      {required this.namaPasien,
      required this.idPasien,
      required this.jenisKelamin,
      required this.tanggalLahir,
      required this.noTelepon,
      required this.fotoPasien,
      required this.username});
}

final class PrefFailure extends PrefState {}
