import 'dart:async';
import 'dart:convert';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_model/reservasi_model.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/antrian_klinik_section/antrian_klinik_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/home_top_bar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/menu_section/menu_section.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/pengumuman.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/home/presentation/widgets/section_title.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/pengumuman_controller.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/api_controller/reservasi_controller.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Pengumuman pengumumanApi = Pengumuman();
  Reservasi reservasiApi = Reservasi();
  late Future<List<DataPengumuman>> listDataPengumuman;
  final StreamController<DataReservasi> _streamController = BehaviorSubject();

  //Data from login
  String varIdPasien = "";
  String varNamaPasien = "";
  String varJenisKelamin = "";
  String varTanggalLahir = "";
  String varNoTelepon = "";
  String varFotoPasien = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      varIdPasien = pref.getString("idPasien")!;
      varNamaPasien = pref.getString("namaPasien")!;
      varJenisKelamin = pref.getString("jenisKelamin")!;
      varTanggalLahir = pref.getString("tanggalLahir")!;
      varNoTelepon = pref.getString("noTelepon")!;
      varFotoPasien = pref.getString("fotoPasien")!;
      print('Enter Home with ID: $varIdPasien');
    });
  }

  pengumumanData() async {
    listDataPengumuman = pengumumanApi.getPengumumanData();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  void initState() {
    super.initState();
    getLoginCred();
    pengumumanData();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getAllReservasi();
    });
  }

  Future<void> getAllReservasi() async {
    var url =
        Uri.parse('https://reservasi.klinikdrcandrasafitri.com/api/reservasi/');

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
              if (!_streamController.isClosed) {
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
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            height: 900,
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      HomeTopBar(varNamaPasien: varNamaPasien),
                      const SizedBox(
                        height: 35,
                      ),
                      PengumumanPage(
                        listDataPengumuman: listDataPengumuman,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SectionTitle(sectionTitle: "Menu"),
                      const SizedBox(
                        height: 19,
                      ),
                      MenuSection(
                        idPasien: varIdPasien,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const SectionTitle(sectionTitle: "Antrian Klinik"),
                      const SizedBox(
                        height: 19,
                      ),
                      AntrianKlinikSection(streamController: _streamController),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ],
            )),
      )),
    );
  }
}
