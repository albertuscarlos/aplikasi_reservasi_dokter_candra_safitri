import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ChangeProfilePicture extends StatefulWidget {
  final String idPasien;
  final File selectedImage;
  const ChangeProfilePicture(
      {super.key, required this.idPasien, required this.selectedImage});

  @override
  State<ChangeProfilePicture> createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Future<void> _updateImage() async {
  //   if (widget.selectedImage == null) {
  //     // Tidak ada gambar yang dipilih
  //     return;
  //   } else {
  //     Dio dio = Dio();
  //     final newImage = widget.selectedImage;
  //     final apiUrl = 'https://reservasi.albertuscarlos-workspace.my.id/api/pasien/foto/update/'; // Gantilah dengan URL API Anda

  //     try {
  //       var stream = http.ByteStream(newImage.openRead());
  //       stream.cast();

  //       var length = await newImage.length();

  //       final uri = Uri.parse(apiUrl + widget.idPasien);
  //       final request = http.MultipartRequest('POST', uri);

  //       var file = http.MultipartFile(
  //         'foto_pasien',
  //         stream,
  //         length
  //       );

  //       request.files.add(file);

  //       final response = await request.send();

  //       if (response.statusCode == 200) {
  //         // Gambar berhasil diupdate
  //         print('Gambar diupdate');
  //       } else {
  //         // Tangani kesalahan
  //         print('Gagal mengupdate gambar');
  //       }

  //       FormData formData = FormData.fromMap({
  //         'foto_pasien' : await MultipartFile.fromFile(newImage.path, filename: 'image.jpg')
  //       });

  //       print(newImage.path);

  //       Response response = await dio.post(apiUrl + widget.idPasien, data: formData);

  //       if (response.statusCode == 200) {
  //         print("Berhasil Update Gambar");
  //         print(response.data);
  //       } else {
  //         print("Gagal Update Gambar");

  //       }

  //     } catch (e) {
  //       // Tangani kesalahan jaringan atau lainnya
  //       print('Error: $e');
  //     }
  //   }
  // }

  Future<void> _updateImage() async {
    if (widget.selectedImage == null) {
      // No image selected
      return;
    }

    final apiUrl =
        'https://reservasi.albertuscarlos-workspace.my.id/api/pasien/foto/update/';

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(apiUrl + widget.idPasien));
      request.headers['Content-Type'] = 'multipart/form-data; charset=utf-8';
      request.headers['Accept'] = '*/*';
      request.headers['Connection'] = 'keep-alive';
      request.headers['Accept-Encoding'] = 'gzip, deflate, br';

      request.files.add(
        await http.MultipartFile.fromPath(
          'foto_pasien',
          widget.selectedImage!.path,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successful upload
        print('Gambar diupdate');
      } else if (response.statusCode == 406) {
        print('Server responded with a 406 status code');
        print('Response Headers: ${response.headers}');
      } else {
        // Handle the error
        print('Gagal mengupdate gambar. Kode status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other exceptions
      print('Error: $e');
    }
  }

// final Dio dio = Dio();
// Future<void> _updateImage() async {
//     try {
//       FormData formData = FormData.fromMap({
//         'image': await MultipartFile.fromFile(widget.selectedImage.path, filename: 'foto_pasien'),
//       });

//       print(widget.selectedImage.path);

//       // Response response = await dio.post(
//       //   'https://reservasi.albertuscarlos-workspace.my.id/api/pasien/foto/' + widget.idPasien,
//       //   data: formData,
//       // );

//       Response response = await dio.post(
//         'https://reservasi.albertuscarlos-workspace.my.id/api/pasien/foto/' + widget.idPasien,
//         data: formData,
//         options: Options(
//           headers: {
//               'Content-Type': 'multipart/form-data; charset=utf-8',
//               'Accept': '*/*',
//               'Connection': 'keep-alive',
//               'Accept-Encoding': 'gzip, deflate, br',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> responseData = json.decode(response.data);
//         String message = responseData['message'];
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(message),
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Error updating image'),
//         ));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

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
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: const Icon(Icons.arrow_back_sharp,
                      color: Color(0xff101623), size: 30),
                ),
                Center(
                  child: Text(
                    "Ganti Foto Profil",
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
            SizedBox(height: 400, child: Image.file(widget.selectedImage!)),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  _updateImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff199A8E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Selesai",
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
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
