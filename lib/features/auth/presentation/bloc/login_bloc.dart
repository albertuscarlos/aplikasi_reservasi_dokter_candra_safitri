import 'package:aplikasi_reservasi_dokter_candra_safitri/core/network/auth_service.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/data/models/body/login_body.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/data/models/response/login_response.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<PostLoginEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await AuthService.postLogin(event.body);
        if (response.data != null) {
          emit(LoginSuccess(response: response));
        } else {
          emit(LoginFailure(errorMessage: response.message));
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
