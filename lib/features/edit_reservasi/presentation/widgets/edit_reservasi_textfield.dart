import 'package:flutter/material.dart';

class EditReservasiTextField extends StatelessWidget {
  EditReservasiTextField(
      {super.key,
      required this.namaLengkapController,
      required this.umurController,
      required this.alamatController,
      required this.noTeleponController});

  final TextEditingController namaLengkapController;
  final TextEditingController umurController;
  final TextEditingController alamatController;
  final TextEditingController noTeleponController;

  final RegExp phoneNumberRegEx = RegExp(r'^[0-9 +]+$');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Nama Lengkap
        TextFormField(
          controller: namaLengkapController,
          keyboardType: TextInputType.text,
          cursorColor: const Color(0xff000000),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffF9FAFB),
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xffA1A8B0),
              )),
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
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.onetwothree_outlined,
                color: Color(0xffA1A8B0),
              )),
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
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.add_location_alt_outlined,
                color: Color(0xffA1A8B0),
              )),
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
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xffA1A8B0),
              )),
          validator: (phoneNumberValue) {
            if (phoneNumberValue!.isEmpty) {
              return "Nomor telepon tidak boleh kosong!";
            } else if (phoneNumberValue.length < 10 ||
                phoneNumberValue.length > 15) {
              return "Nomor telepon tidak valid";
            } else if (!phoneNumberRegEx.hasMatch(phoneNumberValue)) {
              return "Username hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
