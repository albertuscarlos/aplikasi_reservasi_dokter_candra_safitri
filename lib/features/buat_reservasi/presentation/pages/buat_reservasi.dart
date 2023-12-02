import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/buat_reservasi/presentation/widgets/buat_reservasi_button_available.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/buat_reservasi/presentation/widgets/buat_reservasi_button_unavailable.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/buat_reservasi/presentation/widgets/buat_reservasi_textfield.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/pages/reservasi_anda.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/buat_reservasi_topbar.dart';

class BuatReservasiPage extends StatefulWidget {
  final String idPasien;
  const BuatReservasiPage({super.key, required this.idPasien});

  @override
  State<BuatReservasiPage> createState() => _BuatReservasiPageState();
}

class _BuatReservasiPageState extends State<BuatReservasiPage> {
  final GlobalKey<FormState> reservasiFormKey = GlobalKey<FormState>();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController keluhan = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String jam = DateFormat("HH:mm:ss").format(DateTime.now());

  Reservasi reservasiAPI = Reservasi();
  late Future<List<DataReservasi>> listDataReservasi;

  //Data from login
  String varIdPasien = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString('idPasien')!;
    });
  }

  reservasiData() async {
    listDataReservasi = reservasiAPI.getReservasiDataById(widget.idPasien);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginCred();
    reservasiData();
  }

  Future<bool> checkReservationStatus(String idPasien) async {
    try {
      final reservationData = await reservasiAPI.getReservasiDataById(idPasien);

      if (reservationData == null) {
        return true; // Tidak ada data reservasi, pasien dapat membuat reservasi baru.
      } else {
        return false; // Pasien tidak diizinkan membuat reservasi baru karena masih ada reservasi yang belum selesai.
      }
    } catch (e) {
      // Tangani kesalahan yang mungkin terjadi selama pemanggilan API.
      // Anda dapat mencetak pesan kesalahan atau melaporkannya ke layanan pelacakan kesalahan.
      print('Terjadi kesalahan saat memeriksa status reservasi: $e');

      // Kembalikan nilai default atau tindakan yang sesuai dalam kasus kesalahan.
      return true; // Contoh: mengembalikan false jika terjadi kesalahan.
    }
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
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<bool>(
                          future: checkReservationStatus(widget.idPasien),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text(
                                  'Terjadi kesalahan: ${snapshot.error}');
                            } else {
                              final isReservationAllowed = snapshot.data;
                              if (isReservationAllowed != null) {
                                return isReservationAllowed
                                    ? BuatReservasiButtonAvailable(
                                        varIdPasien: varIdPasien,
                                        namaLengkapController:
                                            namaLengkapController,
                                        selectedDate: selectedDate,
                                        umurController: umurController,
                                        alamatController: alamatController,
                                        noTeleponController:
                                            noTeleponController,
                                        reservasiAPI: reservasiAPI,
                                        reservasiFormKey: reservasiFormKey,
                                        buttonLabel: "Buat Reservasi")
                                    : const BuatReservasiButtonUnavailable(
                                        buttonLabel: "Buat Reservasi",
                                        errorMessage:
                                            "Selesaikan Antrian Anda Terlebih Dahulu!");
                              } else {
                                return const Text(
                                    'Terjadi kesalahan: Nilai isReservationAllowed bernilai null');
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
