import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/obscure_password_cubit.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(
      {super.key,
      required this.usernameController,
      required this.passwordController,
      required this.obscurePasswordCubit});

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  final ObscurePasswordCubit obscurePasswordCubit;

  final RegExp usernameRegEx = RegExp(r'^[a-z A-Z 0-9 _ .]+$');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: usernameController,
          maxLength: 15,
          keyboardType: TextInputType.text,
          cursorColor: const Color(0xff000000),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffF9FAFB),
              counterStyle: TextStyle(color: Color(0xff000000)),
              hintText: "Masukkan username anda",
              hintStyle: TextStyle(color: Color(0xffA1A8B0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Color(0xffE5E7EB),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Color(0xffE5E7EB),
                ),
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xffA1A8B0),
              )),
          validator: (usernameValue) {
            if (usernameValue!.isEmpty) {
              return "Username tidak boleh kosong!";
            } else if (usernameValue.length < 4) {
              return "Username tidak boleh kurang dari 4 karakter!";
            } else if (!usernameRegEx.hasMatch(usernameValue)) {
              return "Username hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
            } else {
              return null;
            }
          },
        ),

        const SizedBox(
          width: double.infinity,
          height: 15,
        ),

        //Form Input Password
        BlocBuilder<ObscurePasswordCubit, ObscurePasswordState>(
          bloc: obscurePasswordCubit,
          builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              cursorColor: const Color(0xff000000),
              obscureText: state is ObscurePasswordOn,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffF9FAFB),
                hintText: "Masukkan password anda",
                hintStyle: const TextStyle(color: Color(0xffA1A8B0)),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xffE5E7EB),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xffE5E7EB),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Color(0xffA1A8B0),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (state is ObscurePasswordOff) {
                      obscurePasswordCubit.hidePassword();
                    } else if (state is ObscurePasswordOn) {
                      obscurePasswordCubit.showPassword();
                    }
                  },
                  child: Icon(
                    state is ObscurePasswordOn
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                suffixIconColor: const Color(0xffA1A8B0),
              ),
              validator: (passValue) {
                if (passValue?.isEmpty ?? true) {
                  return "Password tidak boleh kosong!";
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}
