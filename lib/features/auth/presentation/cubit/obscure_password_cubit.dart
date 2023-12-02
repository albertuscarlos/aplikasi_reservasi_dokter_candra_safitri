import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'obscure_password_state.dart';

class ObscurePasswordCubit extends Cubit<ObscurePasswordState> {
  ObscurePasswordCubit() : super(ObscurePasswordOn());

  void hidePassword() {
    emit(ObscurePasswordOn());
  }

  void showPassword() {
    emit(ObscurePasswordOff());
  }
}
