import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/reservasi_anda/presentation/pages/reservasi_anda.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditReservasiButton extends StatelessWidget {
  const EditReservasiButton(
      {super.key,
      required this.idReservasi,
      required this.varIdPasien,
      required this.namaLengkapController,
      required this.umurController,
      required this.alamatController,
      required this.noTeleponController,
      required this.selectedDate,
      required this.reservasiFormKey,
      required this.reservasiAPI});

  final String idReservasi;
  final String varIdPasien;

  final TextEditingController namaLengkapController;
  final TextEditingController umurController;
  final TextEditingController alamatController;
  final TextEditingController noTeleponController;

  final DateTime selectedDate;

  final GlobalKey<FormState> reservasiFormKey;

  final Reservasi reservasiAPI;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (reservasiFormKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Memproses Reservasi Anda'),
              backgroundColor: Color(0xff199A8E),
            ));

            bool response = await reservasiAPI.ubahData(
                idReservasi,
                namaLengkapController.text,
                umurController.text,
                selectedDate.toString(),
                alamatController.text,
                noTeleponController.text,
                varIdPasien);

            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            if (response) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Data reservasil berhasil diubah!'),
                backgroundColor: Color(0xff199A8E),
              ));
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ReservasiAnda(idPasien: varIdPasien)));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    'Ubah data reservasi gagal, silahkan coba lagi!'),
                backgroundColor: Colors.red.shade300,
              ));
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff199A8E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          "Edit Data Reservasi",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
