import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/pages/change_profile_picture.dart';

class ViewProfilePicture extends StatefulWidget {
  final String idPasien;
  const ViewProfilePicture({super.key, required this.idPasien});

  @override
  State<ViewProfilePicture> createState() => _ViewProfilePictureState();
}

class _ViewProfilePictureState extends State<ViewProfilePicture> {
  String fotoPasien = "";

  void getLoginCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      fotoPasien = pref.getString("fotoPasien")!;
      print(fotoPasien);
    });
  }

  //To Update Image
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeProfilePicture(
                      idPasien: widget.idPasien,
                      selectedImage: _selectedImage!,
                    )));
      });
    }
  }

  // Future<void> _updateImage() async {
  //   if (_selectedImage == null) {
  //     // Tidak ada gambar yang dipilih
  //     return;
  //   }

  //   final apiUrl = 'https://reservasi.albertuscarlos-workspace.my.id/api/pasien/foto/update/'; // Gantilah dengan URL API Anda

  //   try {
  //     final uri = Uri.parse(apiUrl + widget.idPasien);
  //     final request = http.MultipartRequest('POST', uri); // Gunakan PUT atau POST tergantung pada API Anda

  //       // Set header content-type
  //       request.headers['Content-Type'] = 'multipart/form-data';

  //     final file = await http.MultipartFile.fromPath('image', _selectedImage!.path);
  //     request.files.add(file);

  //     final response = await request.send();
  //     if (response.statusCode == 200) {
  //       // Gambar berhasil diupdate
  //       print('Gambar diupdate');
  //     } else {
  //       // Tangani kesalahan
  //       print('Gagal mengupdate gambar');
  //     }
  //   } catch (e) {
  //     // Tangani kesalahan jaringan atau lainnya
  //     print('Error: $e');
  //   }
  // }

  Future<void> _updateImage() async {
    if (_selectedImage == null) {
      // Tidak ada gambar yang dipilih
      return;
    }

    final apiUrl =
        'https://reservasi.albertuscarlos-workspace.my.id/api/pasien/foto/update/';

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(apiUrl + widget.idPasien));
      request.fields['title'] = 'Static Title';

      var file = await http.MultipartFile.fromPath(
          'foto_pasien', _selectedImage!.path);
      request.files.add(file);

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Gambar diupdate');
      } else {
        print('Gagal mengupdate gambar. Kode status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
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
                  child: Icon(Icons.arrow_back_sharp,
                      color: Color(0xff101623), size: 30),
                ),
                Center(
                  child: Text(
                    "Foto Profil",
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
              height: 100,
            ),
            SizedBox(height: 400, child: Image.network(fotoPasien)),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  _pickImage();
                },
                child: Text(
                  "Edit",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff199A8E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
