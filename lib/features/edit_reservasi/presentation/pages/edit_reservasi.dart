import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../bloc/edit_reservasi_bloc.dart';
import '../widgets/edit_reservasi_button.dart';
import '../widgets/edit_reservasi_textfield.dart';
import '../widgets/edit_reservasi_topbar.dart';

class EditReservasi extends StatelessWidget {
  EditReservasi({
    super.key,
    required this.idReservasi,
    required this.namaLengkap,
    required this.umur,
    required this.alamat,
    required this.noHp,
  });
  final String idReservasi;
  final String namaLengkap;
  final String umur;
  final String alamat;
  final String noHp;

  final GlobalKey<FormState> reservasiFormKey = GlobalKey<FormState>();

  final DateTime selectedDate = DateTime.now();

  final String jam = DateFormat("HH:mm:ss").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final editReservasiBloc = EditReservasiBloc();
    final TextEditingController namaLengkapController =
        TextEditingController(text: namaLengkap);
    final TextEditingController umurController =
        TextEditingController(text: umur);

    final TextEditingController alamatController =
        TextEditingController(text: alamat);

    final TextEditingController noTeleponController =
        TextEditingController(text: noHp);
    return BlocProvider(
      create: (context) => editReservasiBloc,
      child: BlocListener<EditReservasiBloc, EditReservasiState>(
        listener: (context, state) {
          if (state is EditReservasiSucces) {
            namaLengkapController.clear();
            umurController.clear();
            alamatController.clear();
            noTeleponController.clear();
            Get.snackbar('Berhasil', 'Berhasil Edit Data Reservasi Anda!');
          } else if (state is EditReservasiFailed) {
            Get.snackbar('Gagal', 'Gagal Edit Data Reservasi Anda!');
          }
        },
        child: Scaffold(
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
                      idReservasi: idReservasi,
                      namaLengkapController: namaLengkapController,
                      umurController: umurController,
                      alamatController: alamatController,
                      noTeleponController: noTeleponController,
                      selectedDate: selectedDate,
                      reservasiFormKey: reservasiFormKey,
                      editReservasiBloc: editReservasiBloc,
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
