import 'package:flutter/material.dart';

import '../../../../buat_reservasi/presentation/pages/buat_reservasi.dart';
import '../../../../profile_dokter/pages/profil_dokter.dart';
import '../../../../reservasi_anda/presentation/pages/reservasi_anda.dart';
import 'menu_list.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key, required this.idPasien});

  final String idPasien;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuList(
          img: 'assets/doctor_profile.png',
          menu: 'Profil Dokter',
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileDokter()));
          },
        ),
        MenuList(
            img: 'assets/booking.png',
            menu: 'Buat Reservasi',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuatReservasiPage(idPasien: idPasien),
                ),
              );
            }),
        MenuList(
            img: 'assets/queue.png',
            menu: 'Reservasi Anda',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservasiAnda(idPasien: idPasien),
                ),
              );
            })
        // isWithinMorningRange || isWithinAfternoonRange ? buatReservasi('assets/booking.png', 'Buat Reservasi') : buatReservasiTutup('assets/booking.png', 'Buat Reservasi'),
      ],
    );
  }
}
