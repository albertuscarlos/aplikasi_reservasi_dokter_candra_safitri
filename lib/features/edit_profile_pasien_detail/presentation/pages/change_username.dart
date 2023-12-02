import 'dart:async';

import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pasien_update_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/change_data_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/data_after.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/data_before.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/topbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUsername extends StatefulWidget {
  final String idPasien;
  const ChangeUsername({super.key, required this.idPasien});

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final GlobalKey<FormState> changeUsernameFormKey = GlobalKey<FormState>();
  RegExp usernameRegEx = RegExp(r'^[a-z A-Z 0-9 _ .]+$');
  var usernameSaatIni = "";
  var idPasien = "";

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idPasien = pref.getString("idPasien")!;
      usernameSaatIni = pref.getString("username")!;
    });
  }

  void updateDataFromLoginCred(String usernameBaru) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('username', usernameBaru);
    setState(() {
      usernameSaatIni = usernameBaru;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: usernameSaatIni);
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: changeUsernameFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const EditTopBar(topBarTitle: "Ubah Username"),
              const SizedBox(
                height: 70,
              ),
              DataBefore(
                  subTitle: usernameSaatIni,
                  title: "Username yang digunakan saat ini"),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataAfter(
                    title: "Username Baru",
                    currData: "username baru",
                    textController: usernameController,
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
                    height: 30,
                  ),
                  ChangeDataButton(onPressed: () async {
                    if (changeUsernameFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mengubah Username Anda'),
                        backgroundColor: Color(0xff199A8E),
                      ));

                      bool response = await updatePasienApi.ubahUsernamePasien(
                          usernameController.text, widget.idPasien);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      if (response) {
                        updateDataFromLoginCred(usernameController.text);
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        // content: Text('Nama anda berhasil diubah!'),
                        // backgroundColor: Color(0xff199A8E),
                        // ));
                        _showAlert(
                            "Berhasil!", "Username anda berhasil diganti.");
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop(); // Close the AlertDialog
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                              'Ubah data reservasi gagal, silahkan coba lagi!'),
                          backgroundColor: Colors.red.shade300,
                        ));
                      }
                    }
                  })
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  _showAlert(String title, String subTitle) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff101623),
                ),
              ),
            ),
            content: SizedBox(
              height: 220,
              child: Column(
                children: [Text(subTitle), Image.asset('assets/berhasil.gif')],
              ),
            ),
          );
        });
  }
}
