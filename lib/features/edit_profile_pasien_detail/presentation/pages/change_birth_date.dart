import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_controller/pasien_update_controller.dart';
import '../widgets/change_data_button.dart';
import '../widgets/data_after_readonly.dart';
import '../widgets/data_before.dart';
import '../widgets/topbar.dart';

class ChangeBirth extends StatefulWidget {
  const ChangeBirth({super.key});

  @override
  State<ChangeBirth> createState() => _ChangeBirthState();
}

class _ChangeBirthState extends State<ChangeBirth> {
  final GlobalKey<FormState> changeBirthFormKey = GlobalKey<FormState>();
  final TextEditingController tanggalLahirController = TextEditingController();
  var tanggalLahirSekarang = "";
  var idPasien = "";
  bool isDateTimeHint = true;

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      tanggalLahirSekarang = pref.getString("tanggalLahir")!;
      idPasien = pref.getString("idPasien")!;
      print('id: $idPasien');
    });
  }

  void updateDataFromLoginCred(String tanggalLahirBaru) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('tanggalLahir', tanggalLahirBaru);
    setState(() {
      tanggalLahirSekarang = tanggalLahirBaru;
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
          key: changeBirthFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const EditTopBar(topBarTitle: "Ubah Tanggal Lahir"),
              const SizedBox(
                height: 70,
              ),
              DataBefore(
                  subTitle: tanggalLahirSekarang,
                  title: "Tanggal Lahir Sebelumnya"),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataAfterReadonly(
                      title: "Tanggal Lahir Baru",
                      controller: tanggalLahirController,
                      onTap: () {
                        _getDateFromUser();
                      },
                      isDateTimeHint: isDateTimeHint),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeDataButton(onPressed: () async {
                    if (changeBirthFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Mengubah Tanggal Lahir Anda'),
                        backgroundColor: Color(0xff199A8E),
                      ));

                      bool response =
                          await updatePasienApi.ubahTanggalLahirPasien(
                              tanggalLahirController.text, idPasien);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();

                      if (response) {
                        updateDataFromLoginCred(tanggalLahirController.text);

                        _showAlert("Berhasil!",
                            "Tanggal lahir anda berhasil diganti.");
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop(); // Close the AlertDialog
                        });
                      } else {
                        print(response);
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        locale: const Locale("id", "ID"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030));
    if (_pickerDate != null) {
      String _selectedDate =
          DateFormat('dd MMMM yyyy', 'id').format(_pickerDate);
      setState(() {
        isDateTimeHint = !isDateTimeHint;
        tanggalLahirController.text = _selectedDate;
        print(tanggalLahirController);
      });
    } else {
      print("ERROR");
    }
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
