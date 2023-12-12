import 'package:aplikasi_reservasi_dokter_candra_safitri/core/network/reservasi_service.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/buat_reservasi/data/models/response/get_all_reservasi_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      } catch (e) {}
    });
  }
}
