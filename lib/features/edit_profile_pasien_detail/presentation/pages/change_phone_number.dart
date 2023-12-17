import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_controller/pasien_update_controller.dart';
import '../widgets/change_data_button.dart';
import '../widgets/data_after.dart';
import '../widgets/data_before.dart';
import '../widgets/topbar.dart';

class ChangePhone extends StatefulWidget {
  const ChangePhone({super.key});

  @override
  State<ChangePhone> createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final GlobalKey<FormState> changeNameFormKey = GlobalKey<FormState>();
  final TextEditingController noTeleponController = TextEditingController();
  RegExp phoneNumberRegEx = RegExp(r'^[0-9 +]+$');
  var noTeleponSaatIni = "";
  var idPasien = "";

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      noTeleponSaatIni = pref.getString("noTelepon")!;
      idPasien = pref.getString("idPasien")!;
    });
  }

  void updateDataFromLoginCred(String noTeleponBaru) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('noTelepon', noTeleponBaru);
    setState(() {
      noTeleponSaatIni = noTeleponBaru;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: changeNameFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const EditTopBar(topBarTitle: "Ubah Nomor Telepon"),
              const SizedBox(
                height: 70,
              ),
              DataBefore(
                  subTitle: noTeleponSaatIni,
                  title: "Nomor telepon yang digunakan saat ini"),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataAfter(
                    title: "Nomor Telepon Baru",
                    currData: "Nomor Telepon",
                    textController: noTeleponController,
                    validator: (phoneNumberValue) {
                      if (phoneNumberValue!.isEmpty) {
                        return "Nomor telepon tidak boleh kosong!";
                      } else if (phoneNumberValue.length < 10 ||
                          phoneNumberValue.length > 15) {
                        return "Nomor telepon tidak valid";
                      } else if (!phoneNumberRegEx.hasMatch(phoneNumberValue)) {
                        return "Nomor hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeDataButton(onPressed: () async {
                    if (changeNameFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mengubah Nama Anda'),
                        backgroundColor: Color(0xff199A8E),
                      ));

                      bool response =
                          await updatePasienApi.ubahNomorTeleponPasien(
                              noTeleponController.text, idPasien);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      if (response) {
                        updateDataFromLoginCred(noTeleponController.text);
                        _showAlert("Berhasil!", "Nama anda berhasil diganti.");
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

  Widget nameBefore(String title, String subTitle) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xffd2d6db),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subTitle,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xffd2d6db),
              ),
            ),
          )
        ],
      ),
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
            content: Container(
              height: 220,
              child: Column(
                children: [Text(subTitle), Image.asset('assets/berhasil.gif')],
              ),
            ),
          );
        });
  }
}
