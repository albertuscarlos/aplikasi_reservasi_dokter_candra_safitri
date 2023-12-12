import 'dart:developer';

import 'package:aplikasi_reservasi_dokter_candra_safitri/core/network/reservasi_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/response/get_reservasi_by_id.dart';

part 'reservasi_by_id_event.dart';
part 'reservasi_by_id_state.dart';

class ReservasiByIdBloc extends Bloc<ReservasiByIdEvent, ReservasiByIdState> {
  ReservasiByIdBloc() : super(ReservasiByIdInitial()) {
    on<LoadReservasiById>((event, emit) async {
      emit(ReservasiLoading());

      try {
        final response =
            await ReservasiService.getReservasiById(event.idPasien);

        if (response.status == true) {
          if (response.data != null) {
            log("Success");
            emit(ReservasiSuccess(reservasiById: response.data));
          } else if (response.data == null) {
            log("Null Data");
            emit(ReservasiSuccess(message: "Failed Load Reservasi Data"));
          }
        } else {
          log("Failed");
          emit(ReservasiSuccess(message: response.message!));
        }
      } catch (e) {
        log('ERROR: ${e.toString()}');
      }
    });
  }
}
