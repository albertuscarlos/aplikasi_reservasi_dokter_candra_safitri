import 'dart:developer';

import 'package:aplikasi_reservasi_dokter_candra_safitri/core/network/reservasi_service.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/data/response/reservasi_anda_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reservasi_anda_event.dart';
part 'reservasi_anda_state.dart';

class ReservasiAndaBloc extends Bloc<ReservasiAndaEvent, ReservasiAndaState> {
  ReservasiAndaBloc() : super(ReservasiAndaInitial()) {
    on<LoadReservasiAnda>(
      (event, emit) async {
        emit(ReservasiAndaLoading());

        try {
          final response =
              await ReservasiService.getReservasiAnda(event.idPasien);

          if (response.status == true) {
            emit(ReservasiAndaSuccess(reservasi: response.data!));
          } else {
            emit(ReservasiAndaFailed(err: "Gagal Memuat Data Reservasi"));
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }
}
