import 'dart:developer';

import 'package:aplikasi_reservasi_dokter_candra_safitri/core/network/register_service.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/data/body/signup_body.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/data/response/signup_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<PostSignupEvent>((event, emit) async {
      emit(SignupLoading());

      try {
        final response = await RegisterService.postSignUpData(event.body);

        if (response.status == true) {
          emit(SignupSuccess(response: response));
        } else {
          emit(SignupFailed(failedMessage: response.message));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
