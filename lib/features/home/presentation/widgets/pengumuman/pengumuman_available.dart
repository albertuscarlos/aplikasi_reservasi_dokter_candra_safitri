import 'package:flutter/material.dart';

class PengumumanAvailable extends StatelessWidget {
  const PengumumanAvailable({super.key, required this.pengumuman});
  final String pengumuman;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xff48AFC6).withOpacity(0.42),
                const Color(0xff39A8B4).withOpacity(0.7),
                const Color(0xff199A8E).withOpacity(0.8)
              ],
              stops: const [
                0.5,
                0.8,
                1
              ])),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 13, top: 25),
            child: SizedBox(
              width: 180,
              height: 107,
              child: Center(
                child: Text(
                  pengumuman,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                      width: 134,
                      child: Image.asset(
                          'assets/images_onboarding/onboard_page4.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
