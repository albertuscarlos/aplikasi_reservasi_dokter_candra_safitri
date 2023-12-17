import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/home_service.dart';
import '../../../data/models/response/get_antrian_klinik_response.dart';

part 'antrian_klinik_event.dart';
part 'antrian_klinik_state.dart';

class AntrianKlinikBloc extends Bloc<AntrianKlinikEvent, AntrianKlinikState> {
  AntrianKlinikBloc() : super(AntrianKlinikInitial()) {
    on<LoadAntrianKlinik>((event, emit) async {
      emit(AntrianKlinikLoading());

      try {
        final response = await AntrianKlinikService.getAntrianKlinik();

        if (response.status == true) {
          log("Antrian Klinik Loaded");
          emit(AntrianKlinikSuccess(antrianKlinik: response.data!));
        } else if (response.status == false) {
          emit(AntrianKlinikFailed(error: response.message!));
        }
      } catch (e) {
        log('Antrian Klinik Catch: ${e.toString()}');
      }
    });
  }
}
