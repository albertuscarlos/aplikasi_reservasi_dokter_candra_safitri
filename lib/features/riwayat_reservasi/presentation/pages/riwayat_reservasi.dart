import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/riwayat_reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/riwayat_reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/riwayat_reservasi/presentation/widgets/riwayat_reservasi_list.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/riwayat_reservasi/presentation/widgets/riwayat_reservasi_list_error.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/riwayat_reservasi/presentation/widgets/riwayat_reservasi_topbar.dart';
import 'package:flutter/material.dart';

class RiwayatReservasi extends StatefulWidget {
  const RiwayatReservasi({super.key, required this.idPasien});
  final String idPasien;

  @override
  State<RiwayatReservasi> createState() => _RiwayatReservasiState();
}

class _RiwayatReservasiState extends State<RiwayatReservasi> {
  final Riwayat riwayatApi = Riwayat();
  late Future<List<DataRiwayatReservasi>> listDataRiwayatReservasi;

  riwayatData() async {
    listDataRiwayatReservasi =
        riwayatApi.getRiwayatReservasiById(widget.idPasien);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    riwayatData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff8f9fe),
      child: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const RiwayatReservasiTopBar(),
            const SizedBox(
              height: 70,
            ),
            Expanded(
              child: FutureBuilder<List<DataRiwayatReservasi>>(
                future: listDataRiwayatReservasi,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DataRiwayatReservasi> isiData = snapshot.data!;
                    return ListView.builder(
                      itemCount: isiData.length,
                      itemBuilder: (context, index) {
                        return RiwayatReservasiList(
                            nama: isiData[index].nama_pasien,
                            umur: isiData[index].umur_pasien,
                            alamat: isiData[index].alamat,
                            tanggal: isiData[index].tanggal_reservasi,
                            status: "Pemeriksaan Selesai",
                            antrian: isiData[index].no_antrian);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const RiwayatReservasiListError();
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
    );
  }
}
