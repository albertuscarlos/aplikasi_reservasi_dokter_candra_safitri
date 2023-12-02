import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTopBar extends StatelessWidget {
  const EditTopBar({super.key, required this.topBarTitle});
  final String topBarTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_sharp,
              color: Color(0xff101623), size: 30),
        ),
        Center(
          child: Text(
            topBarTitle,
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
    );
  }
}
