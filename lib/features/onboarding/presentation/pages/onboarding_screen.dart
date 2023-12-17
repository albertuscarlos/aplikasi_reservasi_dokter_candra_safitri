import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/shared_preference.dart';
import '../widgets/intro_page_1.dart';
import '../widgets/intro_page_2.dart';
import '../widgets/intro_page_3.dart';
import '../widgets/intro_page_4.dart';
import 'get_started_page.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController _controller = PageController();
  final ValueNotifier<bool> onLastPage = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //Page View
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                onLastPage.value = (index == 3);
              },
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
                IntroPage4(),
              ],
            ),

            Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ValueListenableBuilder(
                    valueListenable: onLastPage,
                    builder: (context, value, widget) {
                      if (value == true) {
                        return GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(0);
                          },
                          child: const Text(
                            "Kembali",
                            style: TextStyle(
                              color: Color(0xff199A8E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (value == false) {
                        return GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(3);
                          },
                          child: const Text(
                            "Lewati",
                            style: TextStyle(
                              color: Color(0xff199A8E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  //Indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xff199A8E),
                    ),
                  ),
                  //Next
                  ValueListenableBuilder(
                    valueListenable: onLastPage,
                    builder: (context, value, widget) {
                      if (value == true) {
                        return GestureDetector(
                          onTap: () async {
                            int isViewed = 0;
                            await OnBoardingStore.storeOnBoardInfo(isViewed);
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const GetStartedPage();
                                  },
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Selesai",
                            style: TextStyle(
                              color: Color(0xff199A8E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (value == false) {
                        return GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text(
                            "Lanjut",
                            style: TextStyle(
                              color: Color(0xff199A8E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
