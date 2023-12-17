import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/network/home_service.dart';
import '../../../data/models/response/get_pengumuman_response.dart';

part 'pengumuman_event.dart';
part 'pengumuman_state.dart';

class PengumumanBloc extends Bloc<PengumumanEvent, PengumumanState> {
  PengumumanBloc() : super(PengumumanInitial()) {
    on<LoadPengumuman>((event, emit) async {
      emit(PengumumanLoading());

      try {
        final response = await PengumumanService.getPengumuman();

        if (response.status == true) {
          log("Pengumuman Loaded");
          emit(PengumumanSuccess(pengumuman: response));
        } else if (response.status == false) {
          log("Failed to Load");
          emit(PengumumanFailure(errorMessage: response.message!));
        }
      } catch (e) {
        emit(PengumumanFailure(errorMessage: "Gagal Memuat Pengumuman"));
        log(e.toString());
      }
    });
  }
}
