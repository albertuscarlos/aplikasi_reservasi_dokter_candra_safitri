import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/register_service.dart';
import '../../data/body/signup_body.dart';
import '../../data/response/signup_response.dart';

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
