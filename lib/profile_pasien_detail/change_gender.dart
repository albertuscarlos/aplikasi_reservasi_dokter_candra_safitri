import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pasien_update_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeGender extends StatefulWidget {
  const ChangeGender({super.key});

  @override
  State<ChangeGender> createState() => _ChangeGenderState();
}

class _ChangeGenderState extends State<ChangeGender> {
  late String jenisKelamin;
  final GlobalKey<FormState> changeGenderFormKey = GlobalKey<FormState>();
  var jenisKelaminSekarang = "";
  var idPasien = "";

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      jenisKelaminSekarang = pref.getString("jenisKelamin")!;
      idPasien = pref.getString("idPasien")!;
    });
  }

  void updateDataFromLoginCred (String jenisKelaminUpdate)  async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('jenisKelamin', jenisKelaminUpdate);
    setState(() {
      jenisKelaminSekarang = jenisKelaminUpdate;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginCred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: changeGenderFormKey,
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
                        child: Icon(
                          Icons.arrow_back_sharp, color: Color(0xff101623), size: 30),
                      ),
                   
                      Center(
                        child: Text("Ubah Jenis Kelamin",
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
            
                  genderBefore("Jenis kelamin saat ini", jenisKelaminSekarang),
                  SizedBox(
                    height: 20,
                  ),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ubah Jenis Kelamin",
                      style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff717784),
                      ),
                      ),),
                      DropdownSearch<String>(
                        popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        ),
                        items: ["Laki-laki", "Perempuan"],
                        onChanged:(value) {
                          setState(() {
                            jenisKelamin = value!;
                          });
                        },
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          baseStyle: TextStyle(color:Color(0xff000000)),
                            dropdownSearchDecoration: InputDecoration(
                                hintText: "Jenis Kelamin",
                                hintStyle: TextStyle(color: Color(0xffA1A8B0)),                                
                            ),
                        ),
                        validator: (jenisKelamin) {
                          if (jenisKelamin == null) {
                            return "Jenis Kelamin Tidak Boleh Kosong";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              if(changeGenderFormKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: const Text('Mengubah Username Anda'),
                                      backgroundColor: Color(0xff199A8E),
                                  ));
                          
                                  bool response = await updatePasienApi.ubahJenisKelaminPasien(
                                    jenisKelamin.toString(), 
                                    idPasien);
                    
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    
                                  if(response) {
                                    updateDataFromLoginCred(jenisKelamin.toString());
                                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    // content: Text('Nama anda berhasil diubah!'),
                                    // backgroundColor: Color(0xff199A8E),
                                    // ));
                                    _showAlert("Berhasil!", "Jenis kelamin berhasil diganti.");
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop(); // Close the AlertDialog
                                    });
                                    
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Ubah data reservasi gagal, silahkan coba lagi!'),
                                    backgroundColor: Colors.red.shade300,
                                    ));
                                  }  
                              }
                            },
                            child: Text(
                              "Selesai",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff199A8E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                    ),
                        ],
                      ),
                    ],
                  ),              
                ],
              ),
            ),
          )),
    );
  }

  Widget genderBefore (String title, String subTitle) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
          style: GoogleFonts.inter(
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xffd2d6db),
          ),
          ),),
          SizedBox(
            height: 5,
          ),
          Text(subTitle,
          style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xffd2d6db),
          ),
          ),)
        ],
      ),
    );
  }

  _showAlert (String title, String subTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Color(0xff101623),
            ),
            ),),
          content: Container(
            height: 220,
            child: Column(
              children: [
                Text(subTitle),
                Image.asset('assets/berhasil.gif')
              ],
            ),
          ),
        );
      });
  }
}