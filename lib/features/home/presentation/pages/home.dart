import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_pengumuman/pengumuman_bloc.dart';
import '../bloc/get_sharedpreference/pref_bloc.dart';
import '../widgets/antrian_klinik_section/antrian_klinik_section.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/menu_section/menu_section.dart';
import '../widgets/pengumuman/pengumuman.dart';
import '../widgets/section_title.dart';

class Home extends StatefulWidget {
  const Home({super.key});
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
      child: SafeArea(
        child: Scaffold(
          body: ListView(
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
                  return const CircularProgressIndicator();
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
          ),
        ),
      ),
    );
  }
}
