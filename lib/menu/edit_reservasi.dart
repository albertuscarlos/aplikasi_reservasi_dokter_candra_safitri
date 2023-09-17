import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/menu/reservasi_anda.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditReservasi extends StatefulWidget {
  final String idPasien;
  final String idReservasi;
  const EditReservasi({super.key, required this.idReservasi, required this.idPasien});

  @override
  State<EditReservasi> createState() => _EditReservasiState();
}

class _EditReservasiState extends State<EditReservasi> {
  final GlobalKey<FormState> reservasiFormKey = GlobalKey<FormState>();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
	final TextEditingController alamatController = TextEditingController();
	final TextEditingController noTeleponController = TextEditingController();
	final TextEditingController keluhan = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String jam = DateFormat("HH:mm:ss").format(DateTime.now());
  RegExp phoneNumberRegEx = RegExp(r'^[0-9 +]+$');
  Reservasi reservasiAPI = Reservasi();

   //Data from login
  String varIdPasien = "";

  void getLoginCred () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString('idPasien')!;
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
            key: reservasiFormKey,
            child: SingleChildScrollView(
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
                        Icons.arrow_back_ios_new, color: Color(0xff101623), size: 30),
                    ),
                        
                    Center(
                      child: Text("Edit Reservasi",
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
                      
                //Nama Lengkap
                TextFormField(
                  controller: namaLengkapController,
                  keyboardType: TextInputType.text,
                  cursorColor: const Color(0xff000000),
                  decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  counterStyle: TextStyle(
                    color: Color(0xff000000)
                  ),
                  hintText: "Nama Lengkap",
                  hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  prefixIcon: Icon(Icons.person_outline, color: Color(0xffA1A8B0),)
                  ),
                  validator: (namaLengkapValue) {
                    if (namaLengkapValue!.isEmpty) {
                      return "Nama lengkap tidak boleh kosong!";
                    } else {
                      return null;
                    }
                    },
                    ),
                      
                const SizedBox(
                  width: double.infinity,
                  height: 15,
                ),
                      
                //Umur
                  TextFormField(
                          controller: umurController,
                          keyboardType: TextInputType.number,
                          cursorColor: const Color(0xff000000),
                          decoration: const InputDecoration(
                       filled: true,
                       fillColor: Color(0xffF9FAFB),
                       counterStyle: TextStyle(
                         color: Color(0xff000000)
                       ),
                       hintText: "Umur",
                       hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(30)),
                         borderSide: BorderSide(
                           width: 1.0,
                           color: Color(0xffE5E7EB),
                         ),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(30)),
                         borderSide: BorderSide(
                           width: 1.0,
                           color: Color(0xffE5E7EB),
                         ),
                       ),
                       prefixIcon: Icon(Icons.onetwothree_outlined, color: Color(0xffA1A8B0),)
                        ),
                        validator: (umurValue) {
                          if (umurValue!.isEmpty) {
                            return "Umur tidak boleh kosong!";
                          } else if (umurValue.length > 2) {
                            return "Umur tidak boleh lebih dari 2 angka!";
                          } else {
                            return null;
                          }                  
                        },
                  ),
                
                const SizedBox(
                  width: double.infinity,
                  height: 15,
                ),
                      
                //Alamat
                TextFormField(
                  controller: alamatController,
                  keyboardType: TextInputType.text,
                  cursorColor: const Color(0xff000000),
                  maxLines: 2,
                  decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  counterStyle: TextStyle(
                    color: Color(0xff000000)
                  ),
                  hintText: "Alamat",
                  hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  prefixIcon: Icon(Icons.add_location_alt_outlined, color: Color(0xffA1A8B0),)
                  ),
                  validator: (alamatValue) {
                    if (alamatValue!.isEmpty) {
                      return "Alamat tidak boleh kosong!";
                    } else {
                      return null;
                    }
                  },
                ),
                      
                const SizedBox(
                  width: double.infinity,
                  height: 15,
                ),
                
                //Nomor Telepon
                TextFormField(
                  controller: noTeleponController,
                  keyboardType: TextInputType.number,
                  cursorColor: const Color(0xff000000),
                  decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  counterStyle: TextStyle(
                    color: Color(0xff000000)
                  ),
                  hintText: "Nomor Telepon",
                  hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: Color(0xffE5E7EB),
                    ),
                  ),
                  prefixIcon: Icon(Icons.phone, color: Color(0xffA1A8B0),)
                  ),
                  validator: (phoneNumberValue) {
                    if (phoneNumberValue!.isEmpty) {
                      return "Nomor telepon tidak boleh kosong!";
                    } else if (phoneNumberValue.length < 10 || phoneNumberValue.length > 15) {
                      return "Nomor telepon tidak valid";
                      } else if (!phoneNumberRegEx.hasMatch(phoneNumberValue)){
                        return "Username hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
                      }
                    else {
                      return null;
                    }                  
                  },
                ),
            
                const SizedBox(
                 height: 80,
                 ),
                      
                SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if(reservasiFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Memproses Reservasi Anda'),
                          backgroundColor: Color(0xff199A8E),
                      ));
                      
                      bool response = await reservasiAPI.ubahData(
                        widget.idReservasi,
                        namaLengkapController.text, 
                        umurController.text,
                        selectedDate.toString(),
                        alamatController.text, 
                        noTeleponController.text, 
                        varIdPasien);
            
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
            
                      if(response) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Data reservasil berhasil diubah!'),
                        backgroundColor: Color(0xff199A8E),
                        ));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReservasiAnda(idPasien: widget.idPasien)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ubah data reservasi gagal, silahkan coba lagi!'),
                        backgroundColor: Colors.red.shade300,
                        ));
                      }  
                    }
                  },
                  child: Text(
                    "Edit Data Reservasi",
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
            ),
          ),
        )),
    );
  }
}