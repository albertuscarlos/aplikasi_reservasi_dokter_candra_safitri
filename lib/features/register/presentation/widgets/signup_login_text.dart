import 'package:flutter/material.dart';

class SignUpLoginText extends StatelessWidget {
  const SignUpLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Sudah Memiliki Akun? "),
        GestureDetector(
          child: const Text(
            "Masuk Sekarang",
            style: TextStyle(color: Color(0xff199A8E)),
          ),
          onTap: () {
            // Write Tap Code Here.
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => SignUpScreen(),
            //     )
            // );
          },
        )
      ],
    );
  }
}
