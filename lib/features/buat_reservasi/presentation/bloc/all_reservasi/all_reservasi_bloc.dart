import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/reservasi_service.dart';
import '../../../data/models/response/get_all_reservasi_response.dart';

part 'all_reservasi_event.dart';
part 'all_reservasi_state.dart';

class AllReservasiBloc extends Bloc<AllReservasiEvent, AllReservasiState> {
  AllReservasiBloc() : super(AllReservasiInitial()) {
    on<LoadAllReservasi>((event, emit) async {
      emit(AllReservasiLoading());

      try {
        final response = await ReservasiService.getAllReservasi();

        if (response.status == true) {
          emit(AllReservasiSuccess(reservasi: response.data!));
        } else if (response.status == false) {
          emit(AllReservasiFailed(errorMessage: response.message!));
        }
      } catch (e) {
        log('All Reservasi Catch: $e');
      }
    });
  }
}
