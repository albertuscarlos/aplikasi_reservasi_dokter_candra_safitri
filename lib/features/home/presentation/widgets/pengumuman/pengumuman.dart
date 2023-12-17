import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get_pengumuman/pengumuman_bloc.dart';
import 'pengumuman_available.dart';

class PengumumanPage extends StatelessWidget {
  const PengumumanPage({super.key, required this.pengumumanBloc});

  final PengumumanBloc pengumumanBloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<PengumumanBloc, PengumumanState>(
              bloc: pengumumanBloc,
              builder: (context, state) {
                if (state is PengumumanSuccess) {
                  return Builder(
                    builder: (context) {
                      final data = state.pengumuman.data;
                      if (data != null) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 160,
                            viewportFraction: 1.03,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 10),
                          ),
                          items: data.map(
                            (i) {
                              return PengumumanAvailable(
                                  pengumuman: i.pengumuman);
                            },
                          ).toList(),
                        );
                      } else if (data == null) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 160,
                            viewportFraction: 1.03,
                            autoPlay: false,
                          ),
                          items: ['Belum Ada Pengumuman'].map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          const Color(0xff48AFC6)
                                              .withOpacity(0.42),
                                          const Color(0xff39A8B4)
                                              .withOpacity(0.7),
                                          const Color(0xff199A8E)
                                              .withOpacity(0.8)
                                        ],
                                        stops: const [0.5, 0.8, 1],
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 13, top: 25),
                                          child: SizedBox(
                                            width: 180,
                                            height: 107,
                                            child: Center(
                                              child: Text(
                                                i,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 5),
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
                                },
                              );
                            },
                          ).toList(),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                } else if (state is PengumumanFailure) {
                  return PengumumanAvailable(pengumuman: state.errorMessage);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
