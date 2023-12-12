import 'package:aplikasi_reservasi_dokter_candra_safitri/core/shared_preference.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/data/models/body/login_body.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/bloc/login_bloc.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/cubit/obscure_password_cubit.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_register_text.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_text_field.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../navbar/presentation/pages/navbar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final obscurePasswordCubit = ObscurePasswordCubit();
    final loginBloc = LoginBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => obscurePasswordCubit),
        BlocProvider(
          create: (context) => loginBloc,
        ),
      ],
      child: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) async {
          if (state is LoginSuccess) {
            final dataPasien = state.response.data!;
            await LoginDataStore.storeLoginInfo(
                dataPasien.idPasien,
                dataPasien.namaLengkap,
                dataPasien.jenisKelamin,
                dataPasien.tanggalLahir,
                dataPasien.noTelepon,
                dataPasien.fotoPasien,
                dataPasien.username);
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const NavBar(),
                  ),
                  (route) => false);
            }
          } else if (state is LoginFailure) {
            Get.snackbar("Login Gagal", state.errorMessage);
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
                        const LoginTopBar(),
                        const SizedBox(
                          height: 70,
                        ),
                        LoginTextField(
                          usernameController: usernameController,
                          passwordController: passwordController,
                          obscurePasswordCubit: obscurePasswordCubit,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        LoginButton(
                          loginButtonText: "Login",
                          loginBloc: loginBloc,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginBloc.add(
                                PostLoginEvent(
                                  body: LoginBody(
                                      username: usernameController.text,
                                      password: passwordController.text),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const LoginRegisterText(),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
