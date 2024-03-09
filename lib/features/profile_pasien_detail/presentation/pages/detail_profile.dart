import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../edit_profile_pasien_detail/presentation/pages/change_birth_date.dart';
import '../../../edit_profile_pasien_detail/presentation/pages/change_gender.dart';
import '../../../edit_profile_pasien_detail/presentation/pages/change_name.dart';
import '../../../edit_profile_pasien_detail/presentation/pages/change_phone_number.dart';
import '../../../edit_profile_pasien_detail/presentation/pages/change_username.dart';

class ProfilePasien extends StatefulWidget {
  final String idPasien;
  const ProfilePasien({super.key, required this.idPasien});

  @override
  State<ProfilePasien> createState() => _ProfilePasienState();
}

class _ProfilePasienState extends State<ProfilePasien> {
  //Data from login
  String varIdPasien = "";
  String varNamaPasien = "";
  String varJenisKelamin = "";
  String varTanggalLahir = "";
  String varNoTelepon = "";
  String varUsername = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString("idPasien")!;
      varNamaPasien = pref.getString("namaPasien")!;
      varJenisKelamin = pref.getString("jenisKelamin")!;
      varTanggalLahir = pref.getString("tanggalLahir")!;
      varNoTelepon = pref.getString("noTelepon")!;
      varUsername = pref.getString("username")!;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_sharp,
                      color: Color(0xff101623), size: 30),
                ),
                Center(
                  child: Text(
                    "Detail Profil",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff101623),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeName(
                                idPasien: widget.idPasien,
                              )));
                },
                child: detailProfileElement("Nama", varNamaPasien)),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeGender()));
                },
                child: detailProfileElement("Jenis Kelamin", varJenisKelamin)),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangeBirth()));
                },
                child: detailProfileElement("Tanggal Lahir", varTanggalLahir)),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePhone()));
                },
                child: detailProfileElement(
                    "Nomor Telepon", "+62" + varNoTelepon)),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeUsername(
                                idPasien: widget.idPasien,
                              )));
                },
                child: detailProfileElement("Username", varUsername))
          ],
        ),
      )),
    );
  }

  Widget detailProfileElement(String title, String subTitle) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: title == "Username"
                    ? Colors.transparent
                    : const Color(0xffE8F3F1))),
        color: Colors.transparent,
      ),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff101623),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subTitle,
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff717784),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
