import 'package:aplikasi_reservasi_dokter_candra_safitri/features/navbar/presentation/pages/navbar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_dokter/widgets/profile_dokter_about_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_dokter/widgets/profile_dokter_title.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_dokter/widgets/profile_dokter_topbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDokter extends StatelessWidget {
  final String idPasien;
  const ProfileDokter({super.key, required this.idPasien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            ProfilDokterTopBar(
              idPasien: idPasien,
            ),
            const SizedBox(
              height: 53,
            ),
            SizedBox(
                width: 293,
                height: 293,
                child: Image.asset('assets/doctor_profile.png')),
            const SizedBox(
              height: 37,
            ),
            const ProfileDokterTitle(),
            const SizedBox(
              height: 15,
            ),
            const ProfileDokterAboutSection(),
          ],
        ),
      )),
    );
  }
}
