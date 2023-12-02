import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/cubit/obscure_password_cubit.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_register_text.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_text_field.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/widgets/login_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../navbar/presentation/pages/navbar.dart';
import '../../../../api_controller/pasien_login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Pasien pasien = Pasien();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? valIdPasien = pref.getString("idPasien");
    if (valIdPasien != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => NavBar(
                    idPasien: valIdPasien,
                  )),
          (route) => false);
    }
  }

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
                    const LoginTopBar(),
                    const SizedBox(
                      height: 70,
                    ),
                    LoginTextField(
                        usernameController: usernameController,
                        passwordController: passwordController,
                        obscurePasswordCubit: obscurePasswordCubit),
                    const SizedBox(
                      height: 80,
                    ),
                    LoginButton(
                        loginButtonText: "Login",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Processing Data'),
                              backgroundColor: Color(0xff199A8E),
                            ));

                            pasien
                                .postLogin(
                                  usernameController.text,
                                  passwordController.text,
                                )
                                .then((value) => {
                                      if (value != null)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text('Login berhasil!'),
                                            backgroundColor: Color(0xff199A8E),
                                          )),
                                          pageRoute(
                                              value[0]['id_pasien'],
                                              value[0]['nama_lengkap'],
                                              value[0]['jenis_kelamin'],
                                              value[0]['tanggal_lahir'],
                                              value[0]['no_telepon'],
                                              value[0]['foto_pasien'],
                                              value[0]['username'],
                                              value[0]['password'])
                                        }
                                      else if (value == null)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                'Login gagal, silahkan coba lagi!'),
                                            backgroundColor:
                                                Colors.red.shade300,
                                          )),
                                        }
                                    });
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    const LoginRegisterText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pageRoute(
      String idPasien,
      String namaPasien,
      String jenisKelamin,
      String tanggalLahir,
      String noTelepon,
      String fotoPasien,
      String username,
      String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("idPasien", idPasien);
    await pref.setString("namaPasien", namaPasien);
    await pref.setString("jenisKelamin", jenisKelamin);
    await pref.setString("tanggalLahir", tanggalLahir);
    await pref.setString("noTelepon", noTelepon);
    await pref.setString("fotoPasien", fotoPasien);
    await pref.setString("username", username);
    await pref.setString("password", password);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => NavBar(
                  idPasien: idPasien,
                )),
        (route) => false);
  }
}
