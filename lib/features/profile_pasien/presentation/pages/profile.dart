import 'package:flutter/material.dart';

import '../widgets/profile_bottom_section/profile_bottom_section.dart';
import '../widgets/profile_top_section/profile_top_section.dart';

class Profile extends StatefulWidget {
  const Profile(
      {super.key,
      required this.idPasien,
      required this.img,
      required this.namaPasien});
  final String idPasien;
  final String img;
  final String namaPasien;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      ProfileTopSection(
          idPasien: widget.idPasien,
          img: widget.img,
          namaPasien: widget.namaPasien),
      ProfileBottomSection(idPasien: widget.idPasien),
    ]));
  }
}
