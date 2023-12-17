import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/delete_reservasi/delete_reservasi_bloc.dart';
import '../bloc/reservasi_anda/reservasi_anda_bloc.dart';
import '../widgets/reservasi_anda_list.dart';
import '../widgets/reservasi_anda_list_kosong.dart';
import '../widgets/reservasi_anda_topbar.dart';

class ReservasiAnda extends StatefulWidget {
  final String idPasien;
  const ReservasiAnda({super.key, required this.idPasien});

  @override
  State<ReservasiAnda> createState() => _ReservasiAndaState();
}

class _ReservasiAndaState extends State<ReservasiAnda> {
  @override
  Widget build(BuildContext context) {
    final reservasiAndaBloc = ReservasiAndaBloc()
      ..add(LoadReservasiAnda(idPasien: widget.idPasien));
    final deleteReservasiBloc = DeleteReservasiBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => reservasiAndaBloc),
        BlocProvider(create: (context) => deleteReservasiBloc),
      ],
      child: BlocListener<DeleteReservasiBloc, DeleteReservasiState>(
        bloc: deleteReservasiBloc,
        listener: (context, state) {
          if (state is DeleteReservasiSuccess) {
            Get.snackbar('Berhasil', 'Berhasil Menghapus Reservasi');

            reservasiAndaBloc.add(LoadReservasiAnda(idPasien: widget.idPasien));
          } else if (state is DeleteReservasiFailed) {
            Get.snackbar('Gagal', 'Gagal Menghapus Reservasi');
          }
        },
        child: Scaffold(
          body: Container(
            color: const Color(0xfff8f9fe),
            child: SafeArea(
                child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const ReservasiAndaTopBar(),
                  BlocBuilder<ReservasiAndaBloc, ReservasiAndaState>(
                    builder: (context, state) {
                      if (state is ReservasiAndaSuccess) {
                        final isiData = state.reservasi;
                        return Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 70,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
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
                                      deleteReservasiBloc: deleteReservasiBloc,
                                      noHp: isiData[index].noHp,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is ReservasiAndaFailed) {
                        return const Expanded(
                          child: ReservasiAndaListKosong(),
                        );
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
      ),
    );
  }
}
