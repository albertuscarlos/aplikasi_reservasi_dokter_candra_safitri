import 'package:aplikasi_reservasi_dokter_candra_safitri/features/tentang_klinik/presentation/widgets/tentang_klinik_about.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/tentang_klinik/presentation/widgets/tentang_klinik_title.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/tentang_klinik/presentation/widgets/tentang_klinik_topbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TentangKlinik extends StatelessWidget {
  const TentangKlinik({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 30,
          ),
          const TentangKlinikTopBar(),
          const SizedBox(
            height: 53,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/klinik1.jpg',
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 37,
          ),
          TentangKlinikTitle(),
          const SizedBox(
            height: 15,
          ),
          TentangKlinikAbout(),
        ],
      ),
    ));
  }
}
