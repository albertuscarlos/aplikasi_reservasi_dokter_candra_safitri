import 'dart:async';

import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pasien_update_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUsername extends StatefulWidget {
  final String idPasien;
  const ChangeUsername({super.key, required this.idPasien});

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final GlobalKey<FormState> changeUsernameFormKey = GlobalKey<FormState>();
  RegExp usernameRegEx = RegExp(r'^[a-z A-Z 0-9 _ .]+$');
  var usernameSaatIni = "";
  var idPasien = "";

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        idPasien = pref.getString("idPasien")!;
        usernameSaatIni = pref.getString("username")!;
      });
  }

  void updateDataFromLoginCred (String usernameBaru)  async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('username', usernameBaru);
    setState(() {
      usernameSaatIni = usernameBaru;
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
    final TextEditingController usernameController = TextEditingController(text: usernameSaatIni);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: changeUsernameFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(
                        Icons.arrow_back_sharp, color: Color(0xff101623), size: 30),
                    ),
                 
                    Center(
                      child: Text("Ubah Username",
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
          
                nameBefore("Username yang digunakan saat ini", usernameSaatIni),
                SizedBox(
                  height: 20,
                ),
          
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username Baru",
                    style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff717784),
                    ),
                    ),),
                    SizedBox(
                      height: 60,
                      child: TextFormField(
                        controller: usernameController,
                        maxLength: 15,
                        keyboardType: TextInputType.text,
                        cursorColor: const Color(0xff000000),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 0),
                          filled: true,
                          fillColor: Color(0xffF9FAFB),
                          counterStyle: TextStyle(
                            color: Color(0xff000000)
                          ),
                          hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff199A8E), width: 2)
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff199A8E), width: 1)
                          ),
                        ),
                        validator: (usernameValue) {
                          if (usernameValue!.isEmpty) {
                            return "Username tidak boleh kosong!";
                          } else if (usernameValue.length < 4) {
                            return "Username tidak boleh kurang dari 4 karakter!";
                          } else if (!usernameRegEx.hasMatch(usernameValue)){
                            return "Username hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
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
                            if(changeUsernameFormKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: const Text('Mengubah Username Anda'),
                                  backgroundColor: Color(0xff199A8E),
                              ));
                      
                              bool response = await updatePasienApi.ubahUsernamePasien(
                                usernameController.text, 
                                widget.idPasien);
                    
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    
                              if(response) {
                                updateDataFromLoginCred(usernameController.text);
                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                // content: Text('Nama anda berhasil diubah!'),
                                // backgroundColor: Color(0xff199A8E),
                                // ));
                                _showAlert("Berhasil!", "Username anda berhasil diganti.");
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

  Widget nameBefore (String title, String subTitle) {
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