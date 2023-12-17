import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/body/edit_reservasi_body.dart';
import '../bloc/edit_reservasi_bloc.dart';

class EditReservasiButton extends StatelessWidget {
  const EditReservasiButton(
      {super.key,
      required this.idReservasi,
      required this.namaLengkapController,
      required this.umurController,
      required this.alamatController,
      required this.noTeleponController,
      required this.selectedDate,
      required this.reservasiFormKey,
      required this.editReservasiBloc});

  final String idReservasi;

  final TextEditingController namaLengkapController;
  final TextEditingController umurController;
  final TextEditingController alamatController;
  final TextEditingController noTeleponController;

  final DateTime selectedDate;

  final GlobalKey<FormState> reservasiFormKey;

  final EditReservasiBloc editReservasiBloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (reservasiFormKey.currentState!.validate()) {
            editReservasiBloc.add(
              EditReservasi(
                  body: EditReservasiBody(
                      namaPasien: namaLengkapController.text,
                      umurPasien: umurController.text,
                      alamat: alamatController.text,
                      noHp: noTeleponController.text,
                      tanggalReservasi: selectedDate.toString()),
                  idReservasi: idReservasi),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff199A8E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: BlocBuilder<EditReservasiBloc, EditReservasiState>(
          bloc: editReservasiBloc,
          builder: (context, state) {
            if (state is EditReservasiLoading) {
              return const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              return Text(
                "Edit Data Reservasi",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
