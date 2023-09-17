import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/menu/edit_reservasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservasiAnda extends StatefulWidget {
  final String idPasien;
  const ReservasiAnda({super.key, required this.idPasien});

  @override
  State<ReservasiAnda> createState() => _ReservasiAndaState();
}

class _ReservasiAndaState extends State<ReservasiAnda> {
  Reservasi reservasiApi = Reservasi();
  late Future<List<DataReservasi>> listDataReservasi;
  late Future<DataReservasi> delete;

   //Data from login
  String varIdPasien = "";

  void getLoginCred () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString('idPasien')!;
    });
  }

  reservasiData() async {
    listDataReservasi = reservasiApi.getReservasiDataById(widget.idPasien);
    setState(() {});
  }

  @override
  void initState() {
    reservasiData();
    super.initState();
    getLoginCred();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new, color: Color(0xff101623), size: 30),
                    ),
                        
                    Center(
                      child: Text("Reservasi Anda",
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
                  child: FutureBuilder<List<DataReservasi>>(
                    future: listDataReservasi,
                    builder: (context, snapshot){
                      if (snapshot.hasData){
                        List<DataReservasi> isiData = snapshot.data!;
                        return ListView.builder(
                          itemCount: isiData.length,
                          itemBuilder: (context, index){
                            int reverseIndex = isiData.length - 1 - index;
                            return listReservasi(isiData[reverseIndex].nama_pasien, isiData[reverseIndex].umur_pasien, isiData[reverseIndex].alamat, isiData[reverseIndex].tanggal_reservasi, "Proses Pemeriksaan", isiData[reverseIndex].no_antrian, isiData[reverseIndex].id_reservasi, isiData[reverseIndex].id_reservasi);
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
                            Text("Silahkan reservasi terlebih dahulu untuk mendapatkan nomor antrian",
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
      ),
    );
  }

  Widget listReservasi (String nama, String umur, String alamat, String tanggal, String status, String antrian, String delete, String reservasiId) {
    return Container(
                  height: 330,
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
                                  bottom: BorderSide(color: Color(0xfff6f6f6))
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
                                      Icon(Icons.timer_outlined, color: Color(0xfff0ad4e),
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
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Color(0xfff6f6f6))
                          )
                        ),
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
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 172,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color(0xfff6f6f6))
                                )
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  bool response = await reservasiApi.deleteReservasi(delete);
                                  
                                  if(response) {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Berhasil membatalkan reservasi'),
                                      backgroundColor: Color(0xff199A8E),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Gagal  membatalkan reservasi, silahkan coba lagi'),
                                      backgroundColor: Colors.red.shade300,
                                    ));
                                  }
                                  reservasiData();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete_outlined, color: Color(0xffd9534f)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Batalkan Reservasi",
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xffd9534f),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 172,
                              height: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditReservasi(idPasien: widget.idPasien,idReservasi: reservasiId)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit, color: Color(0xfff0ad4e)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Edit Reservasi",
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xfff0ad4e),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
  }

  Widget listReservasiSelesai (String nama, String umur, String alamat, String tanggal, String status, String antrian,) {
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

  Widget reservasiKosong (String img) {
    return  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                SizedBox(
                  width: 280,
                  child: Image.asset(img),
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
                Text("Silahkan reservasi terlebih dahulu untuk mendapatkan nomor antrian",
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
}