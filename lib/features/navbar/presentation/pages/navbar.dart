import 'dart:async';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/pages/home.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/profile_pasien/presentation/pages/profile.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/riwayat_reservasi/presentation/pages/riwayat_reservasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  final String idPasien;
  const NavBar({super.key, required this.idPasien});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  //Data from login
  String varIdPasien = "";
  String varNamaPasien = "";
  String varJenisKelamin = "";
  String varTanggalLahir = "";
  String varNoTelepon = "";
  String varFotoPasien = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString("idPasien")!;
      varNamaPasien = pref.getString("namaPasien")!;
      varJenisKelamin = pref.getString("jenisKelamin")!;
      varTanggalLahir = pref.getString("tanggalLahir")!;
      varNoTelepon = pref.getString("noTelepon")!;
      varFotoPasien = pref.getString("fotoPasien")!;
      print("sharedpref = $varIdPasien");
    });
  }

  Future<void> _reloadLoginCred() async {
    getLoginCred();
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime morningStartTime =
        DateTime(now.year, now.month, now.day, 5, 0); // 05:00 AM
    DateTime morningEndTime =
        DateTime(now.year, now.month, now.day, 6, 45); // 06:45 AM
    DateTime afternoonStartTime =
        DateTime(now.year, now.month, now.day, 14, 0); // 2:00 PM
    DateTime afternoonEndTime =
        DateTime(now.year, now.month, now.day, 18, 45); // 6:45 PM

    bool isWithinMorningRange =
        now.isAfter(morningStartTime) && now.isBefore(morningEndTime);
    bool isWithinAfternoonRange =
        now.isAfter(afternoonStartTime) && now.isBefore(afternoonEndTime);

    final pages = [
      const Home(),
      RiwayatReservasi(idPasien: widget.idPasien),
      Profile(
          idPasien: widget.idPasien,
          img: varFotoPasien,
          namaPasien: varNamaPasien)
    ];
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: _reloadLoginCred, child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
          setState(() {
            _currentIndex = index;
          });
        },
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
