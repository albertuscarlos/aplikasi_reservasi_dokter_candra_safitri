import 'package:aplikasi_reservasi_dokter_candra_safitri/features/onboarding/presentation/pages/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien/presentation/widgets/profile_bottom_section/profile_bottom_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien/presentation/widgets/profile_bottom_section/profile_element.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien/presentation/widgets/profile_top_section/profile_top_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien_detail/presentation/pages/detail_profile.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/edit_profile_pasien_detail/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile(
      {super.key,
      required this.idPasien,
      required this.img,
      required this.namaPasien});
  final String idPasien;
  final String img;
  final String namaPasien;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      ProfileTopSection(
          idPasien: widget.idPasien,
          img: widget.img,
          namaPasien: widget.namaPasien),
      ProfileBottomSection(idPasien: widget.idPasien),
    ]));
  }
}
