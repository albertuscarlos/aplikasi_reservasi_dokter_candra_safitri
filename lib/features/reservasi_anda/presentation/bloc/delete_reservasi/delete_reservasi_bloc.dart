import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/reservasi_service.dart';

part 'delete_reservasi_event.dart';
part 'delete_reservasi_state.dart';

class DeleteReservasiBloc
    extends Bloc<DeleteReservasiEvent, DeleteReservasiState> {
  DeleteReservasiBloc() : super(DeleteReservasiInitial()) {
    on<DeleteReservasi>((event, emit) async {
      emit(DeleteReservasiLoading());

      try {
        final response =
            await ReservasiService.deleteReservasi(event.idReservasi);

        if (response.status == true) {
          log('Delete Success');
          emit(DeleteReservasiSuccess());
        } else {
          log('Delete Failed');
          emit(DeleteReservasiFailed());
        }
      } catch (e) {
        log('Delete Catch: $e');
      }
    });
  }
}
