import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/menu/reservasi_anda.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuatReservasiPage extends StatefulWidget {
  final String idPasien;
  const BuatReservasiPage({super.key, required this.idPasien});

  @override
  State<BuatReservasiPage> createState() => _BuatReservasiPageState();
}

class _BuatReservasiPageState extends State<BuatReservasiPage> {
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
  late Future<List<DataReservasi>> listDataReservasi;

   //Data from login
  String varIdPasien = "";

  void getLoginCred () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString('idPasien')!;
    });
  }

  reservasiData() async {
    listDataReservasi = reservasiAPI.getReservasiDataById(widget.idPasien);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginCred();
    reservasiData();
  }

  Future<bool> checkReservationStatus(String idPasien) async {
  try {
    final reservationData = await reservasiAPI.getReservasiDataById(idPasien);

    if (reservationData == null) {
      return true; // Tidak ada data reservasi, pasien dapat membuat reservasi baru.
    } else {
      return false; // Pasien tidak diizinkan membuat reservasi baru karena masih ada reservasi yang belum selesai.
    }
  } catch (e) {
    // Tangani kesalahan yang mungkin terjadi selama pemanggilan API.
    // Anda dapat mencetak pesan kesalahan atau melaporkannya ke layanan pelacakan kesalahan.
    print('Terjadi kesalahan saat memeriksa status reservasi: $e');

    // Kembalikan nilai default atau tindakan yang sesuai dalam kasus kesalahan.
    return true; // Contoh: mengembalikan false jika terjadi kesalahan.
  }
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
                      child: Text("Buat Reservasi",
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
                height: 100,
                child: 
                Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<bool>(
                        future: checkReservationStatus(widget.idPasien),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Terjadi kesalahan: ${snapshot.error}');
                          } else {
                            final isReservationAllowed = snapshot.data;
                            if (isReservationAllowed != null) {
                              return isReservationAllowed ? buttonAvailable("Buat Reservasi"):buttonUnavailable("Buat Reservasi", "Selesaikan Antrian Anda Terlebih Dahulu!");
                            } else {
                              return Text('Terjadi kesalahan: Nilai isReservationAllowed bernilai null');
                            }
                          }
                          },
                        ),
                    ),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     if(reservasiFormKey.currentState!.validate()) {
                //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //           content: const Text('Memproses Reservasi Anda'),
                //           backgroundColor: Color(0xff199A8E),
                //       ));          
                         
                //       bool response = await reservasiAPI.postData(
                //         namaLengkapController.text, 
                //         umurController.text,
                //         selectedDate.toString(),
                //         alamatController.text, 
                //         noTeleponController.text, 
                //         varIdPasien
                //         );
                          
                //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          
                //       if(response) {
                //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Text('Reservasil berhasil!'),
                //         backgroundColor: Color(0xff199A8E),
                //         ));
                //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReservasiAnda(idPasien: varIdPasien,)));
                //       } else {
                //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         content: Text('Reservasi gagal, silahkan coba lagi!'),
                //         backgroundColor: Colors.red.shade300,
                //         ));
                //       }  
                //     }
                //   },
                //   child: Text(
                //     "Buat Reservasi",
                //     style: GoogleFonts.roboto(
                //       textStyle: const TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 15,
                //         color: Colors.white
                //       ),
                //     ),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color(0xff199A8E),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                // ),
                            ),
                ],
              ),
            ),
          ),
        )),
    );
  }

  Widget buttonAvailable (String buttonLabel) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () async {
                if(reservasiFormKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Memproses Reservasi Anda'),
                      backgroundColor: Color(0xff199A8E),
                  ));          
                                        
                  bool response = await reservasiAPI.postData(
                    namaLengkapController.text, 
                    umurController.text,
                    selectedDate.toString(),
                    alamatController.text, 
                    noTeleponController.text, 
                    varIdPasien
                    );
                                          
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          
                  if(response) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Reservasil berhasil!'),
                    backgroundColor: Color(0xff199A8E),
                    ));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ReservasiAnda(idPasien: varIdPasien,)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Reservasi gagal, silahkan coba lagi!'),
                    backgroundColor: Colors.red.shade300,
                    ));
                  }  
                }
              },
              child: Text(
                buttonLabel,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
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
    );
  }

  Widget buttonUnavailable (String buttonLabel, String errorMessage) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
                                    // Tindakan yang sesuai saat tombol "Selesaikan Reservasi Anda" diklik
            },
            child: Text(
              buttonLabel,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffCDCDCD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber, color: Color(0xffFE5C5C),),
            SizedBox(
              width: 5,
            ),
            Text(errorMessage,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: Color(0xffFE5C5C),
                fontSize: 13,
                fontWeight: FontWeight.w500,                              
              ),
            ),),
          ],
        )
      ],      
    );
  }
}