import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/intro_page_1.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/intro_page_2.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/intro_page_3.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/intro_page_4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  //controllers to keep track of which page we're on
  final PageController _controller = PageController(); 

  //keep track of if we are on the last page or not
  bool onLastPage = false;

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
        children: [
          //Page View
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
            ],
          ),

          //Indicator
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Skip
                onLastPage ?
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(0);
                  },
                  child: const Text(
                    "Kembali",
                    style: TextStyle(
                      color: Color(0xff199A8E),
                      fontWeight: FontWeight.bold,
                    ),
                    )
                    ) 
                    :
                    GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3);
                  },
                  child: const Text(
                    "Lewati",
                    style: TextStyle(
                      color: Color(0xff199A8E),
                      fontWeight: FontWeight.bold,
                    ),
                    )
                    ), 
                //Indicator
                SmoothPageIndicator(controller: _controller, count: 4,effect: const ExpandingDotsEffect(activeDotColor: Color(0xff199A8E)),),
                //Next
                onLastPage ?
                GestureDetector(
                  onTap: () async {
                    await _storeOnBoardInfo();
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context){
                      return const GetStartedPage();
                    }));
                  },
                  child: const Text(
                    "Selesai",
                    style: TextStyle(
                      color: Color(0xff199A8E),
                      fontWeight: FontWeight.bold,
                    ),)) 
                  :
                  GestureDetector(
                  onTap: () {
                    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);  
                  },
                  child: const Text(
                    "Lanjut",
                    style: TextStyle(
                      color: Color(0xff199A8E),
                      fontWeight: FontWeight.bold,
                    ),)) 
                  
              ],
            ))
        ],
      ),
      )
    );
  }
} 