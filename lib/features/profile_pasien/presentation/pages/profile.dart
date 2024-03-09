import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/bloc/get_sharedpreference/pref_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/profile_bottom_section/profile_bottom_section.dart';
import '../widgets/profile_top_section/profile_top_section.dart';

class Profile extends StatelessWidget {
  Profile({
    super.key,
    required this.idPasien,
    required this.img,
    required this.namaPasien,
  });
  final String idPasien;
  final String img;
  final String namaPasien;

  final prefBloc = PrefBloc()..add(LoadPref());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => prefBloc,
        child: RefreshIndicator(
          onRefresh: () async {
            prefBloc.add(LoadPref());
          },
          child: Scaffold(
            body: Stack(
              children: [
                BlocBuilder<PrefBloc, PrefState>(
                  bloc: prefBloc,
                  builder: (context, state) {
                    if (state is PrefSuccess) {
                      return ProfileTopSection(
                        idPasien: state.idPasien,
                        img: img,
                        namaPasien: state.namaPasien,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                ProfileBottomSection(
                  idPasien: idPasien,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
