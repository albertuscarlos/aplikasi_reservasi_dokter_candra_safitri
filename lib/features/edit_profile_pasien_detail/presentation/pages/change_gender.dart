import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_controller/pasien_update_controller.dart';
import '../widgets/change_data_button.dart';
import '../widgets/data_after_drowdown.dart';
import '../widgets/data_before.dart';
import '../widgets/topbar.dart';

class ChangeGender extends StatefulWidget {
  const ChangeGender({super.key});

  @override
  State<ChangeGender> createState() => _ChangeGenderState();
}

class _ChangeGenderState extends State<ChangeGender> {
  late String jenisKelamin;
  final GlobalKey<FormState> changeGenderFormKey = GlobalKey<FormState>();
  var jenisKelaminSekarang = "";
  var idPasien = "";

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      jenisKelaminSekarang = pref.getString("jenisKelamin")!;
      idPasien = pref.getString("idPasien")!;
    });
  }

  void updateDataFromLoginCred(String jenisKelaminUpdate) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('jenisKelamin', jenisKelaminUpdate);
    setState(() {
      jenisKelaminSekarang = jenisKelaminUpdate;
    });
  }

  @override
  void initState() {
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
          key: changeGenderFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const EditTopBar(topBarTitle: "Ubah Jenis Kelamin"),
              const SizedBox(
                height: 70,
              ),
              DataBefore(
                  subTitle: jenisKelaminSekarang,
                  title: "Jenis Kelamin Saat Ini"),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DataAfterDropdown(
                    title: "Jenis Kelamin Baru",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeDataButton(onPressed: () async {
                    if (changeGenderFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mengubah Username Anda'),
                        backgroundColor: Color(0xff199A8E),
                      ));

                      bool response =
                          await updatePasienApi.ubahJenisKelaminPasien(
                              jenisKelamin.toString(), idPasien);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      if (response) {
                        updateDataFromLoginCred(jenisKelamin.toString());
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        // content: Text('Nama anda berhasil diubah!'),
                        // backgroundColor: Color(0xff199A8E),
                        // ));
                        _showAlert(
                            "Berhasil!", "Jenis kelamin berhasil diganti.");
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
