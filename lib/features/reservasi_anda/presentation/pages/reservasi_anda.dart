import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/widgets/reservasi_anda_list.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/widgets/reservasi_anda_list_kosong.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/widgets/reservasi_anda_topbar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_reservasi/presentation/pages/edit_reservasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservasiAnda extends StatefulWidget {
  final String idPasien;
  const ReservasiAnda({super.key, required this.idPasien});

  @override
  State<ReservasiAnda> createState() => _ReservasiAndaState();
}

class _ReservasiAndaState extends State<ReservasiAnda> {
  Reservasi reservasiApi = Reservasi();
  late Future<List<DataReservasi>> listDataReservasi;
  // late Future<DataReservasi> delete;

  //Data from login
  String varIdPasien = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString('idPasien')!;
    });
  }

  reservasiData() async {
    listDataReservasi = reservasiApi.getReservasiDataById(widget.idPasien);
    setState(() {});
  }

  @override
  void initState() {
    reservasiData();
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xfff8f9fe),
        child: SafeArea(
            child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const ReservasiAndaTopBar(),
              const SizedBox(
                height: 70,
              ),
              Expanded(
                child: FutureBuilder<List<DataReservasi>>(
                  future: listDataReservasi,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DataReservasi> isiData = snapshot.data!;
                      return ListView.builder(
                        itemCount: isiData.length,
                        itemBuilder: (context, index) {
                          int reverseIndex = isiData.length - 1 - index;
                          return ListReservasi(
                            idPasien: widget.idPasien,
                            nama: isiData[reverseIndex].nama_pasien,
                            umur: isiData[reverseIndex].umur_pasien,
                            alamat: isiData[reverseIndex].alamat,
                            tanggal: isiData[reverseIndex].tanggal_reservasi,
                            status: "Proses Pemeriksaan",
                            antrian: isiData[reverseIndex].no_antrian,
                            delete: isiData[reverseIndex].id_reservasi,
                            reservasiId: isiData[reverseIndex].id_reservasi,
                            reservasiApi: reservasiApi,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const ReservasiAndaListKosong();
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ));
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
