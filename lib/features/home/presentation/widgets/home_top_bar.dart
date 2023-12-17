import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/get_sharedpreference/pref_bloc.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, required this.prefBloc});

  final PrefBloc prefBloc;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang,",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Color(0xff101623),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BlocBuilder<PrefBloc, PrefState>(
              builder: (context, state) {
                return Text(
                  state is PrefSuccess ? state.namaPasien : "null",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Color(0xff101623),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        //User images
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
