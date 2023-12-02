import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataAfterReadonly extends StatelessWidget {
  const DataAfterReadonly(
      {super.key,
      required this.title,
      required this.controller,
      required this.onTap,
      required this.isDateTimeHint});
  final String title;
  final TextEditingController controller;
  final dynamic Function()? onTap;
  final bool isDateTimeHint;

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
        TextFormField(
            controller: controller,
            readOnly: true,
            onTap: onTap,
            cursorColor: const Color(0xff000000),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 15),
              filled: true,
              fillColor: const Color(0xffF9FAFB),
              counterStyle: const TextStyle(color: Color(0xff000000)),
              hintText: isDateTimeHint ? "Tanggal Lahir" : controller.text,
              hintStyle: const TextStyle(color: Color(0xffA1A8B0)),
              suffixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xffA1A8B0),
              ),
            ),
            validator: (tanggalLahirValue) {
              if (tanggalLahirValue!.isEmpty) {
                return "Tanggal lahir tidak boleh kosong!";
              } else {
                return null;
              }
            }),
      ],
    );
  }
}
