import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/signup_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton(
      {super.key, required this.onPressed, required this.signupBloc});

  final SignupBloc signupBloc;

  final dynamic Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff199A8E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: BlocBuilder<SignupBloc, SignupState>(
          bloc: signupBloc,
          builder: (context, state) {
            if (state is SignupLoading) {
              return const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state is SignupSuccess) {
              return Text(
                "Sign Up",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              );
            }
            return Text(
              "Sign Up",
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
