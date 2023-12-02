import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeDataButton extends StatelessWidget {
  const ChangeDataButton({super.key, required this.onPressed});
  final dynamic Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onPressed,
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
        ),
      ],
    );
  }
}
