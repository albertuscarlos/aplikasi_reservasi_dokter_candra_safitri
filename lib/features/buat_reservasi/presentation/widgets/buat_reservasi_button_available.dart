import 'package:aplikasi_reservasi_dokter_candra_safitri/features/buat_reservasi/presentation/bloc/buat_reservasi/buat_reservasi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BuatReservasiButtonAvailable extends StatelessWidget {
  const BuatReservasiButtonAvailable(
      {super.key, this.buttonLabel, this.onPressed, this.buatReservasiBloc});

  final String? buttonLabel;
  final dynamic Function()? onPressed;
  final BuatReservasiBloc? buatReservasiBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff199A8E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: BlocBuilder<BuatReservasiBloc, BuatReservasiState>(
              bloc: buatReservasiBloc,
              builder: (context, state) {
                if (state is BuatReservasiLoading) {
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
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
      ],
    );
  }
}
