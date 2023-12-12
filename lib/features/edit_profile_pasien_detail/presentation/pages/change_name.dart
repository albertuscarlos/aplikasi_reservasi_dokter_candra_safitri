import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pasien_update_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/change_data_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/data_after.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/data_before.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/presentation/widgets/topbar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/bloc/get_sharedpreference/pref_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeName extends StatefulWidget {
  final String idPasien;
  const ChangeName({super.key, required this.idPasien});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  final GlobalKey<FormState> changeNameFormKey = GlobalKey<FormState>();
  var idPasien = "";
  var namaSaatIni = "";

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idPasien = pref.getString("idPasien")!;
      namaSaatIni = pref.getString("namaPasien")!;
    });
  }

  void updateDataFromLoginCred(String namaBaru) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('namaPasien', namaBaru);
    setState(() {
      namaSaatIni = namaBaru;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController namaLengkapController =
        TextEditingController(text: namaSaatIni);

    final prefBloc = PrefBloc();

    return BlocProvider(
      create: (context) => prefBloc,
      child: Scaffold(
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
                const EditTopBar(
                  topBarTitle: "Ubah Nama",
                ),
                const SizedBox(
                  height: 70,
                ),
                DataBefore(
                    subTitle: namaSaatIni,
                    title: "Nama yang digunakan saat ini"),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DataAfter(
                      title: "Nama Baru",
                      currData: namaSaatIni,
                      textController: namaLengkapController,
                      validator: (namaLengkapValue) {
                        if (namaLengkapValue!.isEmpty) {
                          return "Nama lengkap tidak boleh kosong!";
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
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Mengubah Nama Anda'),
                          backgroundColor: Color(0xff199A8E),
                        ));

                        bool response = await updatePasienApi.ubahNamaPasien(
                            namaLengkapController.text, idPasien);
                        print('response: $response');

                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                        if (response) {
                          // prefBloc.add(LoadPref());
                          updateDataFromLoginCred(namaLengkapController.text);
                          _showAlert(
                              "Berhasil!", "Nama anda berhasil diganti.");
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context)
                                .pop(); // Close the AlertDialog
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
