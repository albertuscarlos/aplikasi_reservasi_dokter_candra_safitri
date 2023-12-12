import 'package:aplikasi_reservasi_dokter_candra_safitri/features/buat_reservasi/presentation/bloc/reservasi_by_id/reservasi_by_id_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BuatReservasiButtonUnavailable extends StatelessWidget {
  const BuatReservasiButtonUnavailable(
      {super.key, this.buttonLabel, this.errorMessage, this.reservasiByIdBloc});

  final String? buttonLabel;
  final String? errorMessage;
  final ReservasiByIdBloc? reservasiByIdBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Tindakan yang sesuai saat tombol "Selesaikan Reservasi Anda" diklik
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffCDCDCD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: BlocBuilder<ReservasiByIdBloc, ReservasiByIdState>(
              builder: (context, state) {
                if (state is ReservasiLoading) {
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Text(
                    buttonLabel!,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<ReservasiByIdBloc, ReservasiByIdState>(
          bloc: reservasiByIdBloc,
          builder: (context, state) {
            if (state is ReservasiLoading) {
              return const SizedBox();
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber,
                    color: Color(0xffFE5C5C),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    errorMessage!,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xffFE5C5C),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        )
      ],
    );
  }
}
