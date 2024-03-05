import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/shared_preference.dart';
import '../../../home/presentation/bloc/get_sharedpreference/pref_bloc.dart';
import '../../../home/presentation/pages/home.dart';
import '../../../profile_pasien/presentation/pages/profile.dart';
import '../../../riwayat_reservasi/presentation/pages/riwayat_reservasi.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  ValueNotifier<String> idPasien = ValueNotifier('');
  ValueNotifier<String> namaPasien = ValueNotifier('');
  ValueNotifier<String> jenisKelamin = ValueNotifier('');
  ValueNotifier<String> tanggalLahir = ValueNotifier('');
  ValueNotifier<String> noTelepon = ValueNotifier('');
  ValueNotifier<String> fotoPasien = ValueNotifier('');
  ValueNotifier<String> username = ValueNotifier('');

  void getLoginCred() async {
    idPasien.value = (await LoginDataStore.getIdPasien())!;
    namaPasien.value = (await LoginDataStore.getNamaPasien())!;
    jenisKelamin.value = (await LoginDataStore.getJenisKelamin())!;
    tanggalLahir.value = (await LoginDataStore.getTanggalLahir())!;
    noTelepon.value = (await LoginDataStore.getNoTelepon())!;
    fotoPasien.value = (await LoginDataStore.getFotoPasien())!;
    username.value = (await LoginDataStore.getUsername())!;

    log('Enter Home with ID: ${idPasien.value}');
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();

    // DateTime morningStartTime =
    //     DateTime(now.year, now.month, now.day, 5, 0); // 05:00 AM
    // DateTime morningEndTime =
    //     DateTime(now.year, now.month, now.day, 6, 45); // 06:45 AM
    // DateTime afternoonStartTime =
    //     DateTime(now.year, now.month, now.day, 14, 0); // 2:00 PM
    // DateTime afternoonEndTime =
    //     DateTime(now.year, now.month, now.day, 18, 45); // 6:45 PM

    // bool isWithinMorningRange =
    //     now.isAfter(morningStartTime) && now.isBefore(morningEndTime);
    // bool isWithinAfternoonRange =
    //     now.isAfter(afternoonStartTime) && now.isBefore(afternoonEndTime);

    final riwayatBloc = PrefBloc()..add(LoadPref());

    final pages = [
      const Home(),
      BlocProvider(
        create: (context) => riwayatBloc,
        child: BlocBuilder<PrefBloc, PrefState>(
          bloc: riwayatBloc,
          builder: (context, state) {
            if (state is PrefSuccess) {
              return RiwayatReservasi(idPasien: state.idPasien);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      Profile(
        idPasien: idPasien.value,
        img: fotoPasien.value,
        namaPasien: namaPasien.value,
      )
    ];
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, value, widget) {
              return pages[_currentIndex.value];
            }),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentIndex,
          builder: (context, value, widget) {
            return BottomNavigationBar(
              currentIndex: value,
              selectedFontSize: 15,
              selectedItemColor: const Color(0xff199A8E),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    backgroundColor: Color(0xffffffff),
                    label: "Beranda"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    backgroundColor: Color(0xffffffff),
                    label: "Riwayat"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    backgroundColor: Color(0xffffffff),
                    label: "Profile"),
              ],
              onTap: (index) {
                _currentIndex.value = index;
                log("${_currentIndex.value}");
              },
            );
          },
        ),
      ),
    );
  }

  Widget buatReservasiTutup(String img, String menu) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 110),
        height: 50,
        width: 110,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          color: Color(0xff199A8E),
        ),
        child: Column(children: [
          Text(
            "Buka:",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xffF6F6F6),
              ),
            ),
          ),
          Text(
            "5:00 - 06:45",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xffF6F6F6),
              ),
            ),
          ),
          Text(
            "14:00 - 18:45",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Color(0xffF6F6F6),
              ),
            ),
          )
        ]),
      ),
      Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border.all(color: const Color(0xffCDCDCD)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 70, child: Center(child: Image.asset(img))),
              const SizedBox(
                height: 5,
              ),
              Text(
                menu,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    color: Color(0xff101623),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
      Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            border: Border.all(color: const Color(0xffCDCDCD)),
            color: Colors.grey.withOpacity(0.5)),
      )
    ]);
  }
}
