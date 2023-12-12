import 'dart:developer';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/bloc/get_pengumuman/pengumuman_bloc.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/bloc/get_sharedpreference/pref_bloc.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/antrian_klinik_section/antrian_klinik_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/home_top_bar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/menu_section/menu_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/pengumuman/pengumuman.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/section_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  // final ValueNotifier<String> varNamaPasien;
  // final ValueNotifier<String> varIdPasien;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final prefBloc = PrefBloc()..add(LoadPref());
    final pengumumanBloc = PengumumanBloc()..add(LoadPengumuman());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => prefBloc),
        BlocProvider(create: (context) => pengumumanBloc),
      ],
      child: Scaffold(
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 50,
            ),
            HomeTopBar(
              prefBloc: prefBloc,
            ),
            const SizedBox(
              height: 35,
            ),
            PengumumanPage(
              pengumumanBloc: pengumumanBloc,
            ),
            const SizedBox(
              height: 20,
            ),
            const SectionTitle(sectionTitle: "Menu"),
            const SizedBox(
              height: 19,
            ),
            BlocBuilder<PrefBloc, PrefState>(
              builder: (context, state) {
                if (state is PrefSuccess) {
                  return MenuSection(
                    idPasien: state.idPasien,
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            const SizedBox(
              height: 50,
            ),
            const SectionTitle(sectionTitle: "Antrian Klinik"),
            const SizedBox(
              height: 19,
            ),
            const AntrianKlinikSection(),
            const SizedBox(
              height: 30,
            )
          ],
        )),
      ),
    );
  }
}
