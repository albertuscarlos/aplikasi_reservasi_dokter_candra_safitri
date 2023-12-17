import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/reservasi_service.dart';
import '../../data/body/edit_reservasi_body.dart';

part 'edit_reservasi_event.dart';
part 'edit_reservasi_state.dart';

class EditReservasiBloc extends Bloc<EditReservasiEvent, EditReservasiState> {
  EditReservasiBloc() : super(EditReservasiInitial()) {
    on<EditReservasi>(
      (event, emit) async {
        emit(EditReservasiLoading());

        try {
          final response = await ReservasiService.editReservasi(
              event.body, event.idReservasi);

          if (response.status == true) {
            emit(EditReservasiSucces());
          } else if (response.status == false) {
            emit(EditReservasiFailed());
          }
        } catch (e) {
          log('Edit Catch: $e');
        }
      },
    );
  }
}
