import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/cubit/obscure_password_cubit.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/pages/login.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_login_text.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_text_field.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/widgets/signup_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../api_controller/pasien_login_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<String> jenisKelamin = ValueNotifier('');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Pasien pasien = Pasien();

  @override
  Widget build(BuildContext context) {
    final obscurePasswordCubit = ObscurePasswordCubit();
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => obscurePasswordCubit)],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: formKey,
                child: Column(
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
                        obscurePasswordCubit: obscurePasswordCubit),
                    const SizedBox(
                      height: 80,
                    ),
                    SignUpButton(onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        //show snackbar to indicate loading
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Processing Data'),
                          backgroundColor: Color(0xff199A8E),
                        ));

                        bool response = await pasien.postData(
                            namaLengkapController.text,
                            jenisKelamin.value,
                            tanggalLahirController.text,
                            noTeleponController.text,
                            usernameController.text,
                            passwordController.text);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                        if (response) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Registrasi akun berhasil!'),
                            backgroundColor: Color(0xff199A8E),
                          ));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                'Registrasi akun gagal, silahkan coba lagi!'),
                            backgroundColor: Colors.red.shade300,
                          ));
                        }
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
        ),
      ),
    );
  }
}
