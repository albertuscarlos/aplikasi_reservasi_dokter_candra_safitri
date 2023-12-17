import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../edit_profile_pasien_detail/profile_picture.dart';

class ProfileTopSection extends StatelessWidget {
  const ProfileTopSection(
      {super.key,
      required this.idPasien,
      required this.img,
      required this.namaPasien});

  final String idPasien;
  final String img;
  final String namaPasien;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xff52D1C6), Color(0xff30ADA2)])),
        child: Stack(children: [
          SizedBox(
            height: 370,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: 120,
                        width: 120,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProfilePicture(
                                        idPasien: idPasien)));
                          },
                          child:
                              CircleAvatar(backgroundImage: NetworkImage(img)),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Text(
                    namaPasien,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffffffff))),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
