import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/cubit/obscure_password_cubit.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/data/body/signup_body.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/bloc/signup_bloc.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_login_text.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_text_field.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<String> jenisKelamin = ValueNotifier('');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final obscurePasswordCubit = ObscurePasswordCubit();
    final signupBloc = SignupBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => obscurePasswordCubit),
        BlocProvider(create: (context) => signupBloc),
      ],
      child: BlocConsumer<SignupBloc, SignupState>(
        bloc: signupBloc,
        listener: (context, state) {
          if (state is SignupSuccess) {
            namaLengkapController.clear();
            jenisKelamin.value = '';
            tanggalLahirController.clear();
            noTeleponController.clear();
            usernameController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
            Get.snackbar("Sign Up Success", state.response.message);
          } else if (state is SignupFailed) {
            Get.snackbar("Sign Up Failed", state.failedMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: formKey,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const SignUpTopBar(),
                      const SizedBox(
                        height: 70,
                      ),
                      SignUpTextField(
                        namaLengkapController: namaLengkapController,
                        tanggalLahirController: tanggalLahirController,
                        noTeleponController: noTeleponController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        jenisKelamin: jenisKelamin,
                        obscurePasswordCubit: obscurePasswordCubit,
                        signupBloc: signupBloc,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      SignUpButton(
                          signupBloc: signupBloc,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              signupBloc.add(
                                PostSignupEvent(
                                  body: SignUpBody(
                                    namaLengkap: namaLengkapController.text,
                                    jenisKelamin: jenisKelamin.value,
                                    tanggalLahir: tanggalLahirController.text,
                                    noTelepon: noTeleponController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                ),
                              );
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const SignUpLoginText(),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
