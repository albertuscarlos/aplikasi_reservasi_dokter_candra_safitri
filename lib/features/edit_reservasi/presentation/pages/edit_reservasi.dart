import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_reservasi/presentation/widgets/edit_reservasi_button.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_reservasi/presentation/widgets/edit_reservasi_textfield.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_reservasi/presentation/widgets/edit_reservasi_topbar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/pages/reservasi_anda.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditReservasi extends StatefulWidget {
  final String idPasien;
  final String idReservasi;
  const EditReservasi(
      {super.key, required this.idReservasi, required this.idPasien});

  @override
  State<EditReservasi> createState() => _EditReservasiState();
}

class _EditReservasiState extends State<EditReservasi> {
  final GlobalKey<FormState> reservasiFormKey = GlobalKey<FormState>();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController keluhan = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String jam = DateFormat("HH:mm:ss").format(DateTime.now());

  Reservasi reservasiAPI = Reservasi();

  //Data from login
  String varIdPasien = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString('idPasien')!;
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
          key: reservasiFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const EditReservasiTopBar(),
                const SizedBox(
                  height: 70,
                ),
                EditReservasiTextField(
                    namaLengkapController: namaLengkapController,
                    umurController: umurController,
                    alamatController: alamatController,
                    noTeleponController: noTeleponController),
                const SizedBox(
                  height: 80,
                ),
                EditReservasiButton(
                    idReservasi: widget.idReservasi,
                    varIdPasien: varIdPasien,
                    namaLengkapController: namaLengkapController,
                    umurController: umurController,
                    alamatController: alamatController,
                    noTeleponController: noTeleponController,
                    selectedDate: selectedDate,
                    reservasiFormKey: reservasiFormKey,
                    reservasiAPI: reservasiAPI),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
