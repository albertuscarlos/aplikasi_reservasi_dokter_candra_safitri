import 'dart:developer';

import 'package:aplikasi_reservasi_dokter_candra_safitri/core/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pref_event.dart';
part 'pref_state.dart';

class PrefBloc extends Bloc<PrefEvent, PrefState> {
  PrefBloc() : super(PrefInitial()) {
    on<LoadPref>((event, emit) async {
      emit(PrefLoading());

      try {
        final namaPasien = await LoginDataStore.getNamaPasien();
        final idPasien = await LoginDataStore.getIdPasien();

        if (namaPasien != null || idPasien != null) {
          emit(PrefSuccess(namaPasien: namaPasien!, idPasien: idPasien!));
        } else {
          emit(PrefFailure());
        }
      } catch (e) {
        log("Pref Catch: $e");
      }
    });
  }
}
