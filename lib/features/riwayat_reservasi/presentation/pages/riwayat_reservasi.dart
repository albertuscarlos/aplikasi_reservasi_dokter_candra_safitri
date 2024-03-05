import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/riwayat_reservasi_bloc.dart';
import '../widgets/riwayat_reservasi_list.dart';
import '../widgets/riwayat_reservasi_list_error.dart';
import '../widgets/riwayat_reservasi_topbar.dart';

class RiwayatReservasi extends StatelessWidget {
  const RiwayatReservasi({super.key, required this.idPasien});
  final String idPasien;

  @override
  Widget build(BuildContext context) {
    final riwayatReservasiBloc = RiwayatReservasiBloc()
      ..add(LoadRiwayatReservasi(idPasien: idPasien));
    return Container(
      color: const Color(0xfff8f9fe),
      child: SafeArea(
        child: BlocProvider(
          create: (context) => riwayatReservasiBloc,
          child: Scaffold(
            body: Container(
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
                  BlocBuilder<RiwayatReservasiBloc, RiwayatReservasiState>(
                    bloc: riwayatReservasiBloc,
                    builder: (context, state) {
                      if (state is RiwayatReservasiSuccess) {
                        final data = state.riwayatReservasi;
                        return Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              return RiwayatReservasiList(
                                nama: data[index].namaPasien,
                                umur: data[index].umur,
                                alamat: data[index].alamat,
                                tanggal: data[index].tanggalReservasi,
                                antrian: data[index].noAntrian,
                                status: 'Pemeriksaan Selesai',
                              );
                            },
                          ),
                        );
                      } else if (state is RiwayatReservasiFailed) {
                        return const RiwayatReservasiListError();
                      } else {
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
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
