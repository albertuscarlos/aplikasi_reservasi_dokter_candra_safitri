import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataAfterDropdown extends StatelessWidget {
  const DataAfterDropdown({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xff717784),
            ),
          ),
        ),
        DropdownSearch<String>(
          popupProps: const PopupProps.menu(
            showSelectedItems: true,
          ),
          items: const ["Laki-laki", "Perempuan"],
          onChanged: (value) {
            // setState(() {
            //   jenisKelamin = value!;
            // });
          },
          dropdownDecoratorProps: const DropDownDecoratorProps(
            baseStyle: TextStyle(color: Color(0xff000000)),
            dropdownSearchDecoration: InputDecoration(
              hintText: "Jenis Kelamin",
              hintStyle: TextStyle(color: Color(0xffA1A8B0)),
            ),
          ),
          validator: (jenisKelamin) {
            if (jenisKelamin == null) {
              return "Jenis Kelamin Tidak Boleh Kosong";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
