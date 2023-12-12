import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/bloc/reservasi_anda_bloc.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/widgets/reservasi_anda_list.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/widgets/reservasi_anda_list_kosong.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/widgets/reservasi_anda_topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservasiAnda extends StatefulWidget {
  final String idPasien;
  const ReservasiAnda({super.key, required this.idPasien});

  @override
  State<ReservasiAnda> createState() => _ReservasiAndaState();
}

class _ReservasiAndaState extends State<ReservasiAnda> {
  Reservasi reservasiApi = Reservasi();
  late Future<List<DataReservasi>> listDataReservasi;

  @override
  Widget build(BuildContext context) {
    final reservasiAndaBloc = ReservasiAndaBloc()
      ..add(LoadReservasiAnda(idPasien: widget.idPasien));
    return BlocProvider(
      create: (context) => reservasiAndaBloc,
      child: Scaffold(
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
                BlocBuilder<ReservasiAndaBloc, ReservasiAndaState>(
                  builder: (context, state) {
                    if (state is ReservasiAndaSuccess) {
                      final isiData = state.reservasi;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: isiData.length,
                          itemBuilder: (context, index) {
                            return ListReservasi(
                                idPasien: isiData[index].idPasien,
                                nama: isiData[index].namaPasien,
                                umur: isiData[index].umurPasien,
                                alamat: isiData[index].alamat,
                                antrian: isiData[index].noAntrian,
                                delete: isiData[index].idReservasi,
                                reservasiId: isiData[index].idReservasi,
                                status: "Proses Pemeriksaan",
                                tanggal: isiData[index].tanggalReservasi,
                                reservasiApi: reservasiApi);
                          },
                        ),
                      );
                    } else if (state is ReservasiAndaFailed) {
                      return const ReservasiAndaListKosong();
                    }
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
