import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pasien_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeBirth extends StatefulWidget {
  const ChangeBirth({super.key});

  @override
  State<ChangeBirth> createState() => _ChangeBirthState();
}

class _ChangeBirthState extends State<ChangeBirth> {
  final GlobalKey<FormState> changeBirthFormKey = GlobalKey<FormState>();
  final TextEditingController tanggalLahirController = TextEditingController();
  var tanggalLahirSekarang = "";
  var idPasien = "";
  bool isDateTimeHint = true; 

  UpdatePasien updatePasienApi = UpdatePasien();

  void getLoginCred () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      setState(() {
        tanggalLahirSekarang= pref.getString("tanggalLahir")!;
        idPasien= pref.getString("idPasien")!;
      });
  }

  void updateDataFromLoginCred (String tanggalLahirBaru)  async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('tanggalLahir', tanggalLahirBaru);
    setState(() {
      tanggalLahirSekarang = tanggalLahirBaru;
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
            key: changeBirthFormKey,
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
                      child: Text("Ubah Tanggal Lahir",
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
          
                birthBefore("Tanggal lahir sebelumnya", tanggalLahirSekarang),
                SizedBox(
                  height: 20,
                ),
          
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tanggal Lahir Baru",
                    style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff717784),
                    ),
                    ),),
                    TextFormField(
                      controller: tanggalLahirController,
                      readOnly: true,
                      onTap: (){
                        _getDateFromUser();
                      },
                      cursorColor: const Color(0xff000000),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        filled: true,
                        fillColor: Color(0xffF9FAFB),
                        counterStyle: TextStyle(
                          color: Color(0xff000000)
                        ),
                        hintText: isDateTimeHint ? "Tanggal Lahir" : tanggalLahirController.text,
                        hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                        suffixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xffA1A8B0),),
                      ),
                      validator: (tanggalLahirValue) {
                      if (tanggalLahirValue!.isEmpty) {
                        return "Tanggal lahir tidak boleh kosong!";
                      } else {
                        return null;
                      }
                      }
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
                            if(changeBirthFormKey.currentState!.validate()) {
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: const Text('Mengubah Tanggal Lahir Anda'),
                                      backgroundColor: Color(0xff199A8E),
                                  ));
                          
                                  bool response = await updatePasienApi.ubahTanggalLahirPasien(
                                    tanggalLahirController.text, 
                                    idPasien);
                        
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        
                                  if(response) {
                                    updateDataFromLoginCred(tanggalLahirController.text);
                                    
                                    _showAlert("Berhasil!", "Tanggal lahir anda berhasil diganti.");
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

  Widget birthBefore (String title, String subTitle) {
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        locale: const Locale("id", "ID"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030)
    );
    if(_pickerDate != null ){
      String _selectedDate = DateFormat('dd MMMM yyyy', 'id').format(_pickerDate); 
      setState(() {
        isDateTimeHint = !isDateTimeHint;
        tanggalLahirController.text = _selectedDate;
        print(tanggalLahirController);
      });
    } else {
      print("ERROR");
    }
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