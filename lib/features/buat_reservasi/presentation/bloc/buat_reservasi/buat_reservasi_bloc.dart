import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/reservasi_service.dart';
import '../../../data/models/body/post_reservasi_body.dart';

part 'buat_reservasi_event.dart';
part 'buat_reservasi_state.dart';

class BuatReservasiBloc extends Bloc<BuatReservasiEvent, BuatReservasiState> {
  BuatReservasiBloc() : super(BuatReservasiInitial()) {
    on<CreateReservasi>((event, emit) async {
      emit(BuatReservasiLoading());

      try {
        final response = await ReservasiService.postReservasi(event.body);
        if (response.status == true) {
          emit(BuatReservasiSuccess());
        } else {
          emit(BuatReservasiFailed());
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
