import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/riwayat_reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/riwayat_reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/profile_pasien.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/profile_pasien_detail/profile_picture.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pengumuman_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/menu/buat_reservasi.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/menu/profil_dokter.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/menu/reservasi_anda.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  final String idPasien;
  const HomePage({super.key, required this.idPasien});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {  
  Pengumuman pengumumanApi = Pengumuman();
  Reservasi reservasiApi = Reservasi();
  Riwayat riwayatApi = Riwayat();
  late Future<List<DataRiwayatReservasi>> listDataRiwayatReservasi;
  late Future<List<DataPengumuman>> listDataPengumuman;
  StreamController<DataReservasi> _streamController = BehaviorSubject();
  int _currentIndex = 0;

  //Data from login
  String varIdPasien = "";
  String varNamaPasien = "";
  String varJenisKelamin = "";
  String varTanggalLahir = "";
  String varNoTelepon = "";
  String varFotoPasien = "";

  void getLoginCred () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString("idPasien")!;
      varNamaPasien = pref.getString("namaPasien")!;
      varJenisKelamin = pref.getString("jenisKelamin")!;
      varTanggalLahir = pref.getString("tanggalLahir")!;
      varNoTelepon = pref.getString("noTelepon")!;
      varFotoPasien = pref.getString("fotoPasien")!;
      print("sharedpref = ${varIdPasien}");
    });
  }

  Future<void> _reloadLoginCred () async {
    getLoginCred();
  }

  pengumumanData() async {
    listDataPengumuman = pengumumanApi.getPengumumanData();
    setState(() {});
  }
  
  riwayatData() async {
    listDataRiwayatReservasi = riwayatApi.getRiwayatReservasiById(widget.idPasien);
    setState(() {});
  }

  @override
  void dispose () {
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
    pengumumanData();
    riwayatData();
    Timer.periodic(Duration(seconds: 3), (timer) {
      getAllReservasi();
    });
    
  }

Future<void> getAllReservasi() async {
  var url = Uri.parse('https://reservasi.albertuscarlos-workspace.my.id/api/reservasi/');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonParsed = jsonDecode(response.body);

      if (jsonParsed['data'] != null) {
        var reservasiData = jsonParsed['data'] as List<dynamic>;

        for (var i = 0; i < reservasiData.length; i++) {
          var data = reservasiData[i];
          if (i == 0) {
            var reservasi = DataReservasi.fromJson(data);
            if(!_streamController.isClosed){
              _streamController.sink.add(reservasi);
            }
          }
        }
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load Data');
    }
  } catch (e) {
    // Handle the error gracefully, you can add error data to the stream
    if (!_streamController.isClosed) {
      _streamController.sink.addError(e.toString());
    }
  }
}

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime morningStartTime = DateTime(now.year, now.month, now.day, 5, 0); // 05:00 AM
    DateTime morningEndTime = DateTime(now.year, now.month, now.day, 6, 45); // 06:45 AM
    DateTime afternoonStartTime = DateTime(now.year, now.month, now.day, 14, 0); // 2:00 PM
    DateTime afternoonEndTime = DateTime(now.year, now.month, now.day, 18, 45); // 6:45 PM

    bool isWithinMorningRange = now.isAfter(morningStartTime) && now.isBefore(morningEndTime);
    bool isWithinAfternoonRange = now.isAfter(afternoonStartTime) && now.isBefore(afternoonEndTime);

    final pages = [
      homePage(),
      riwayatReservasi(),
      profilPasien(varNamaPasien, varFotoPasien),
    ];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _reloadLoginCred,
        child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 15,
        selectedItemColor: Color(0xff199A8E),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Color(0xffffffff),
            label: "Beranda"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            backgroundColor: Color(0xffffffff),
            label: "Riwayat"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            backgroundColor: Color(0xffffffff),
            label: "Profile"
            ),            
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      
    );
  }

  Widget homePage () {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang,",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              color: Color(0xff101623),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,                              
                            ),
                          ),
                        ),
                        Text(
                          varNamaPasien,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              color: Color(0xff101623),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,                              
                            ),
                          ),
                        ),
                      ],
                    ),
                    //User images
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<DataPengumuman>>(
                          future: listDataPengumuman,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DataPengumuman> isiData = snapshot.data!;
                              return CarouselSlider(
                                options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 1.03,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 10),
                                ),
                                items: isiData.map((i){
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [Color(0xff48AFC6).withOpacity(0.42),Color(0xff39A8B4).withOpacity(0.7),Color(0xff199A8E).withOpacity(0.8)], stops: const [0.5, 0.8, 1])
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 13, top: 25),
                                              child: SizedBox(
                                                width: 180,
                                                height: 107,
                                                child: Center(
                                                  child: Text('${i.pengumuman}',
                                                  textAlign: TextAlign.center, 
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600)))),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(right: 5),
                                                      child: SizedBox(
                                                        width: 134,
                                                        child: Image.asset('assets/images_onboarding/onboard_page4.png'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            } else if (snapshot.hasError) {
                              return  CarouselSlider(
                                options: CarouselOptions(
                                  height: 160,
                                  viewportFraction: 1.03,
                                  autoPlay: false,
                                ),
                                items: ['Belum Ada Pengumuman'].map((i){
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [Color(0xff48AFC6).withOpacity(0.42),Color(0xff39A8B4).withOpacity(0.7),Color(0xff199A8E).withOpacity(0.8)], stops: const [0.5, 0.8, 1])
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 13, top: 25),
                                              child: SizedBox(
                                                width: 180,
                                                height: 107,
                                                child: Center(
                                                  child: Text('${i}',
                                                  textAlign: TextAlign.center, 
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600)))),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(right: 5),
                                                      child: SizedBox(
                                                        width: 134,
                                                        child: Image.asset('assets/images_onboarding/onboard_page4.png'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
        
                            }
                            return Center(child: CircularProgressIndicator());
                            }                          
                          )
                        ), 
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Menu",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xff101623),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,                              
                      ),
                    ),),
                  ],
                ),
                const SizedBox(
                  height: 19,
                
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    profilDokter('assets/doctor_profile.png', 'Profil Dokter'),
                    // isWithinMorningRange || isWithinAfternoonRange ? buatReservasi('assets/booking.png', 'Buat Reservasi') : buatReservasiTutup('assets/booking.png', 'Buat Reservasi'),
                    buatReservasi('assets/booking.png', 'Buat Reservasi'),
                    reservasiAnda('assets/queue.png', 'Reservasi Anda'),                    
                  ],                  
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text("Antrian Klinik",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xff101623),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,                              
                      ),
                    ),),
                  ],
                ),
        
                const SizedBox(
                  height: 19,
                ),
        
                SizedBox(
                  height: 108,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<DataReservasi>(
                          stream: _streamController.stream, 
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // Kasus: Sedang memuat data
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              // Kasus: Terjadi kesalahan
                              return antrianKlinikKosong("A-000", "Belum ada antrian klinik", "${DateFormat('MMMM dd, yyyy - hh:mm a').format(DateTime.now())}", "Belum ada pemeriksaan");
                            } else if (!snapshot.hasData || snapshot.data == null) {
                              // Kasus: Tidak ada data atau data null
                              return Text('Tidak ada data.');
                            } else {
                              // Kasus: Data sudah tersedia
                              return antrianKlinik(snapshot.data!, "Proses Pemeriksaan");
                            }
                            // switch(snapdata.connectionState) {
                            //   case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
                            //   default: if (snapdata.hasError){
                            //     return Text("Please Wait");
                            //   } else if (snapdata.data == null){
                            //     return Text("Tidak Ada Antrian");
                            //   } else {
                            //     return antrianKlinik(snapdata.data!, "Proses Pemeriksaan");
                            //   }
                            // }
                          }
                        ),
                        
                        // FutureBuilder<List<DataReservasi>>(
                        //   future: listAllDataReservasi,
                        //   builder: (context, snapshot){
                        //     if (snapshot.hasData){
                        //       List<DataReservasi> isiData = snapshot.data!;
                        //       return ListView.builder(
                        //         itemCount: isiData.length,
                        //         itemBuilder: (context, index){
                        //           return isiData[index].status_reservasi == "Proses" ? antrianKlinik(isiData[index].no_antrian, isiData[index].tanggal_reservasi, isiData[index].nama_pasien, isiData[index].status_reservasi == "Proses" ? "Proses Pemeriksaan" : "Pemeriksaan Selesai") : Container();
                        //         },
                        //       );
                        //     } else if (snapshot.hasError){
                        //       return Text("Anda Belum Melakukan Reservasi");
                             
                        //     }
                        //     return Center(child: CircularProgressIndicator(
                        //       backgroundColor: Colors.black,
                        //       valueColor: AlwaysStoppedAnimation<Color>(
                        //         Colors.white,
                        //       ),
                        //     )
                        //     );
                        //   },
                        // ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 30,
                )
                
              ],
            ),
          ),
        )
      );
  }

  Widget profilDokter (String img, String menu) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilDokter(idPasien: widget.idPasien)));
      },
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffCDCDCD))
        ),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: Image.asset(img)
            ),
            SizedBox(
              height: 5,
            ),
            Text(menu, 
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xff101623),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,                              
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget buatReservasi (String img, String menu) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BuatReservasiPage(idPasien: widget.idPasien)));  
      },
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffCDCDCD))
        ),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: Center(child: Image.asset(img))
            ),
            SizedBox(
              height: 5,
            ),
            Text(menu, 
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xff101623),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,                              
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget buatReservasiTutup (String img, String menu) {
    return Stack(
      children: [
      Container(
        margin: EdgeInsets.only(top: 110),
        height: 50,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)
          ),
          color: Color(0xff199A8E),
        ),
        child: Column(
          children: [
            Text("Buka:", 
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffF6F6F6),
                ),
              ),),
            Text("5:00 - 06:45",
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffF6F6F6),
                ),
              ),),
            Text("14:00 - 18:45",
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffF6F6F6),
                ),
              ),)
        ]),
      ),
      Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          border: Border.all(color: Color(0xffCDCDCD)),
        ),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: Center(child: Image.asset(img))
            ),
            SizedBox(
              height: 5,
            ),
            Text(menu, 
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xff101623),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,                              
                ),
              ),
            ),
          ],
        )
      ),
      Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          border: Border.all(color: Color(0xffCDCDCD)),
          color: Colors.grey.withOpacity(0.5)
        ),
      )
        
      ] 
    );
  }

  Widget reservasiAnda (String img, String menu) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReservasiAnda(idPasien: varIdPasien,)));  
      },
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffCDCDCD))
        ),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              child: Image.asset(img)
            ),
            SizedBox(
              height: 5,
            ),
            Text(menu, 
            style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xff101623),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,                              
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget antrianKlinik (DataReservasi dataReservasi, String statusReservasi) {
    return Container(
                  height: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff199A8E),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 13,
                      ),
                      Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                          color: Color(0xff51C9BE),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text(dataReservasi.no_antrian,
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF6F6F6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 23, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dataReservasi.tanggal_reservasi, 
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffF6F6F6),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(dataReservasi.nama_pasien, 
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffF6F6F6),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, color: Color(0xfff0ad4e), size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(statusReservasi,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xfff0ad4e),
                                    ),
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                );
  }

  Widget antrianKlinikKosong (String noAntrian, String antrianKosong, String tanggalHariIni, String statusReservasi) {
    return Container(
                  height: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff199A8E),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 13,
                      ),
                      Container(
                        height: 84,
                        width: 84,
                        decoration: BoxDecoration(
                          color: Color(0xff51C9BE),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text(noAntrian,
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF6F6F6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 23, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tanggalHariIni, 
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffF6F6F6),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(antrianKosong, 
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffF6F6F6),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, color: Color(0xfff0ad4e), size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(statusReservasi,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xfff0ad4e),
                                    ),
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                );
  }

  Widget riwayatReservasi () {
    return Container(
        color: Color(0xfff8f9fe),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [                        
                    Center(
                      child: Text("Riwayat Reservasi",
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

                Expanded(
                  child: FutureBuilder<List<DataRiwayatReservasi>>(
                    future: listDataRiwayatReservasi,
                    builder: (context, snapshot){
                      if (snapshot.hasData){
                        List<DataRiwayatReservasi> isiData = snapshot.data!;
                        return ListView.builder(
                          itemCount: isiData.length,
                          itemBuilder: (context, index){
                            return listRiwayatReservasi(isiData[index].nama_pasien, isiData[index].umur_pasien, isiData[index].alamat, isiData[index].tanggal_reservasi, "Pemeriksaan Selesai", isiData[index].no_antrian);
                          },
                        );
                      } else if (snapshot.hasError){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            SizedBox(
                              width: 280,
                              child: Image.asset('assets/oops.png'),
                            ),
                            Text("Anda Belum Melakukan Reservasi", 
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff101623),
                                    ),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Silahkan reservasi terlebih dahulu untuk mendapatkan riwayat reservasi",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff717784),
                              )
                            )
                            )
                          ],
                        );
                       
                      }
                      return Center(child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      )
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      );
  }

  Widget listRiwayatReservasi (String nama, String umur, String alamat, String tanggal, String status, String antrian,) {
    return Container(
                  height: 280,
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xfff6f6f6))
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$nama, $umur",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 15,
											          fontWeight: FontWeight.bold,
											          color: Color(0xff101623),
                              ),
                            )
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(alamat,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff717784),
                              )
                            )),
                          ],
                        )
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Color(0xfff6f6f6)),
                                )
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 160,
                              padding: EdgeInsets.only(top: 12, left: 12),
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color(0xfff6f6f6))
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tanggal Reservasi", 
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff101623),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(tanggal,
                                   style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff717784),
                                    )
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              width: 182,
                              padding: EdgeInsets.only(top: 12, left: 12),
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Status Reservasi", 
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff101623),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.verified_outlined, color: Color(0xff5cb85c),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(status,
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            letterSpacing: 0.5,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xff5cb85c),
                                          ),
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text("Antrian Anda",
                            style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff101623),
                                    ),
                                  )),
                            SizedBox(
                              height: 15,
                            ),
                            Text(antrian,
                            style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff101623),
                                    ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
  }

  Widget profilPasien (String namaPasien, String img) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                colors: [Color(0xff52D1C6),Color(0xff30ADA2)])
              ),
              child: Stack(
                children: [
                  Container(
                    height: 370,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: 
                          [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProfilePicture(idPasien: widget.idPasien)));
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(img)),
                                )
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 5,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       _pickImage();
                            //     },
                            //     child: Container(
                            //       height: 35,
                            //       width: 35,
                            //       decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: Colors.grey.shade200,
                            //       ),
                            //       child: Icon(Icons.camera_alt_outlined, color: Colors.grey),
                            //     ),
                            //   )
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          height: 50,
                          child: Text(namaPasien,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffffffff)
                            )
                          ),),
                        )
                      ],
                    ),
                  ),
                ]
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                    color: Color(0xffffffff),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePasien(idPasien: widget.idPasien))); 
                            },  
                            child: profileElement(Icons.person_2_outlined, "Detail Profil")),
                          Divider(
                            thickness: 1,
                            height: 20,
                            color: Color(0xffE8F3F1),
                          ), 
                          profileElement(Icons.emergency_outlined, "Tentang Klinik"),
                          Divider(
                            thickness: 1,
                            height: 20,
                            color: Color(0xffE8F3F1),
                          ), 
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences pref= await SharedPreferences.getInstance();
                              await pref.remove("idPasien");
                              await pref.remove("namaPasien");
                              await pref.remove("jenisKelamin");
                              await pref.remove("tanggalLahir");
                              await pref.remove("noTelepon");
                              await pref.remove("fotoPasien");
                              await pref.remove("username");
                              await pref.remove("password");
                                _streamController.close();
                                // Navigate to the login or home page, for example
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GetStartedPage()),(route) => false);
                            },
                            child: profileElement(Icons.warning_amber, "Keluar"))
                        ],
                      ),
                    ),
                  ),
                )
              )
            ],
          )
        ]
      )
      );
  }

  Widget profileElement (IconData icon, String label) {
    return Container(
      height: 50,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [ 
            Row(
              children: [
                Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffE8F3F1),
                  ),
                  child: Icon(icon , color: label != "Keluar" ? Color(0xff199A8E) : Color(0xffFE5C5C)),
                ),
                SizedBox(
                  width: 17,
                ),
                Text(label,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: label != "Keluar" ? Color(0xff101623) : Color(0xffFE5C5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,                              
                  ),
                ),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 40,
                  child: label != "Keluar" ? Icon(Icons.arrow_forward_ios, color: Color(0xff555555), size: 25,) : Icon(Icons.arrow_forward_ios, color: Colors.transparent, size: 25,))
              ],
            )
            ]
          ),
        ],
      ),
    );
  }

}