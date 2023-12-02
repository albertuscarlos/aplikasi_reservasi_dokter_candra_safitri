import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataAfter extends StatelessWidget {
  const DataAfter(
      {super.key,
      required this.title,
      required this.currData,
      required this.textController,
      required this.validator});
  final String title;
  final String currData;
  final TextEditingController textController;
  final String? Function(String?)? validator;

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
            controller: textController,
            keyboardType: title == "Nomor Telepon Baru"
                ? TextInputType.number
                : TextInputType.text,
            cursorColor: const Color(0xff000000),
            maxLength: title == "Username Baru" ? 15 : null,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 0),
                filled: true,
                fillColor: const Color(0xffF9FAFB),
                counterStyle: const TextStyle(color: Color(0xff000000)),
                hintText: currData,
                hintStyle: const TextStyle(color: Color(0xffA1A8B0)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff199A8E), width: 2)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff199A8E), width: 1))),
            validator: validator),
      ],
    );
  }
}
