import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileElement extends StatelessWidget {
  const ProfileElement({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            Row(
              children: [
                Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffE8F3F1),
                  ),
                  child: Icon(icon,
                      color: label != "Keluar"
                          ? const Color(0xff199A8E)
                          : const Color(0xffFE5C5C)),
                ),
                const SizedBox(
                  width: 17,
                ),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: label != "Keluar"
                          ? const Color(0xff101623)
                          : const Color(0xffFE5C5C),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    height: 40,
                    child: label != "Keluar"
                        ? const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff555555),
                            size: 25,
                          )
                        : const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.transparent,
                            size: 25,
                          ))
              ],
            )
          ]),
        ],
      ),
    );
  }
}
