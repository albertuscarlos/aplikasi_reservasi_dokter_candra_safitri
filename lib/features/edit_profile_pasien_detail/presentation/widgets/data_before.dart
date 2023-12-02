import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataBefore extends StatelessWidget {
  const DataBefore({super.key, required this.subTitle, required this.title});
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xffd2d6db),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subTitle,
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xffd2d6db),
              ),
            ),
          )
        ],
      ),
    );
  }
}
