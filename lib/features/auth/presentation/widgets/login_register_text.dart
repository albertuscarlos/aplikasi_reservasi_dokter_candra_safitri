import 'package:aplikasi_reservasi_dokter_candra_safitri/features/register/presentation/pages/signup.dart';
import 'package:flutter/material.dart';

class LoginRegisterText extends StatelessWidget {
  const LoginRegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum Memiliki Akun? "),
        GestureDetector(
          child: const Text(
            "Registrasi Sekarang",
            style: TextStyle(color: Color(0xff199A8E)),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            );
          },
        )
      ],
    );
  }
}
