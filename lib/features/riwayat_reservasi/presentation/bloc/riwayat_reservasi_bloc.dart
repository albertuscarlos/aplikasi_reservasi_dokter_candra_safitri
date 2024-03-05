import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/riwayat_reservasi_service.dart';
import '../../data/riwayat_reservasi_response.dart';

part 'riwayat_reservasi_event.dart';
part 'riwayat_reservasi_state.dart';

class RiwayatReservasiBloc
    extends Bloc<RiwayatReservasiEvent, RiwayatReservasiState> {
  RiwayatReservasiBloc() : super(RiwayatReservasiInitial()) {
    on<LoadRiwayatReservasi>((event, emit) async {
      emit(RiwayatReservasiLoading());

      try {
        final response =
            await RiwayatReservasiService.getRiwayatReservasi(event.idPasien);

        if (response.status == true) {
          log('Riwayat Success');
          emit(RiwayatReservasiSuccess(riwayatReservasi: response.data));
        } else if (response.status == false) {
          log('Riwayat Failed');
          emit(RiwayatReservasiFailed());
        }
      } catch (e) {
        log('Load Riwayat Reservasi Catch: $e');
      }
    });
  }
}
