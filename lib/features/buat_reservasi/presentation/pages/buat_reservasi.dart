import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/body/post_reservasi_body.dart';
import '../bloc/buat_reservasi/buat_reservasi_bloc.dart';
import '../bloc/reservasi_by_id/reservasi_by_id_bloc.dart';
import '../widgets/buat_reservasi_button_available.dart';
import '../widgets/buat_reservasi_button_unavailable.dart';
import '../widgets/buat_reservasi_textfield.dart';
import '../widgets/buat_reservasi_topbar.dart';

class BuatReservasiPage extends StatelessWidget {
  final String idPasien;
  BuatReservasiPage({super.key, required this.idPasien});

  final GlobalKey<FormState> reservasiFormKey = GlobalKey<FormState>();

  final TextEditingController namaLengkapController = TextEditingController();

  final TextEditingController umurController = TextEditingController();

  final TextEditingController alamatController = TextEditingController();

  final TextEditingController noTeleponController = TextEditingController();

  final TextEditingController keluhan = TextEditingController();

  final DateTime selectedDate = DateTime.now();

  final String jam = DateFormat("HH:mm:ss").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final reservasiByIdBloc = ReservasiByIdBloc()
      ..add(LoadReservasiById(idPasien: idPasien));
    final buatReservasiBloc = BuatReservasiBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => reservasiByIdBloc),
        BlocProvider(
          create: (context) => buatReservasiBloc,
        ),
      ],
      child: BlocListener<BuatReservasiBloc, BuatReservasiState>(
        bloc: buatReservasiBloc,
        listener: (context, state) {
          if (state is BuatReservasiSuccess) {
            namaLengkapController.clear();
            umurController.clear();
            alamatController.clear();
            noTeleponController.clear();
            Get.snackbar("Berhasil Melakukan Reservasi!",
                "Silahkan Buka Menu Reservasi Anda untuk Melihat Nomor Antrian Anda");
          } else if (state is BuatReservasiFailed) {
            Get.snackbar("Gagal Melakukan Reservasi ", "Silahkan Coba Lagi");
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
                      const BuatReservasiTopBar(),
                      const SizedBox(
                        height: 70,
                      ),
                      BuatReservasiTextField(
                          namaLengkapController: namaLengkapController,
                          alamatController: alamatController,
                          umurController: umurController,
                          noTeleponController: noTeleponController),
                      const SizedBox(
                        height: 80,
                      ),
                      BlocBuilder<ReservasiByIdBloc, ReservasiByIdState>(
                        bloc: reservasiByIdBloc,
                        builder: (context, state) {
                          if (state is ReservasiSuccess) {
                            if (state.reservasiById == null) {
                              return BuatReservasiButtonAvailable(
                                buatReservasiBloc: buatReservasiBloc,
                                buttonLabel: "Buat Reservasi",
                                onPressed: () async {
                                  if (reservasiFormKey.currentState!
                                      .validate()) {
                                    buatReservasiBloc.add(
                                      CreateReservasi(
                                        body: PostReservasiBody(
                                            idPasien: idPasien,
                                            namaPasien:
                                                namaLengkapController.text,
                                            umurPasien: umurController.text,
                                            tanggalReservasi:
                                                selectedDate.toString(),
                                            alamatPasien: alamatController.text,
                                            noHp: noTeleponController.text),
                                      ),
                                    );
                                  }
                                },
                              );
                            } else {
                              return const BuatReservasiButtonUnavailable(
                                  buttonLabel: "Buat Reservasi",
                                  errorMessage:
                                      "Selesaikan Antrian Anda Terlebih Dahulu!");
                            }
                          } else if (state is ReservasiLoading) {
                            return BuatReservasiButtonUnavailable(
                              reservasiByIdBloc: reservasiByIdBloc,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
