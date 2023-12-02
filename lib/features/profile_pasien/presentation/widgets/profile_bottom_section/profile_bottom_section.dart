import 'package:aplikasi_reservasi_dokter_candra_safitri/features/onboarding/presentation/pages/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien/presentation/widgets/profile_bottom_section/profile_element.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien_detail/presentation/pages/detail_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBottomSection extends StatelessWidget {
  const ProfileBottomSection({super.key, required this.idPasien});

  final String idPasien;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
            height: 300,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Color(0xffffffff),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePasien(idPasien: idPasien)));
                          },
                          child: const ProfileElement(
                              icon: Icons.person_2_outlined,
                              label: "Detail Profil")),
                      const Divider(
                        thickness: 1,
                        height: 20,
                        color: Color(0xffE8F3F1),
                      ),
                      const ProfileElement(
                          icon: Icons.emergency_outlined,
                          label: "Tentang Klinik"),
                      const Divider(
                        thickness: 1,
                        height: 20,
                        color: Color(0xffE8F3F1),
                      ),
                      GestureDetector(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            await pref.remove("idPasien");
                            await pref.remove("namaPasien");
                            await pref.remove("jenisKelamin");
                            await pref.remove("tanggalLahir");
                            await pref.remove("noTelepon");
                            await pref.remove("fotoPasien");
                            await pref.remove("username");
                            await pref.remove("password");
                            // _streamController.close();
                            // Navigate to the login or home page, for example
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GetStartedPage()),
                                (route) => false);
                          },
                          child: const ProfileElement(
                              icon: Icons.warning_amber, label: "Keluar"))
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
