import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuList extends StatelessWidget {
  const MenuList(
      {super.key, required this.img, required this.menu, required this.onTap});

  final String img;
  final String menu;
  final dynamic Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 110,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffCDCDCD))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 70, child: Image.asset(img)),
              const SizedBox(
                height: 5,
              ),
              Text(
                menu,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    color: Color(0xff101623),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
