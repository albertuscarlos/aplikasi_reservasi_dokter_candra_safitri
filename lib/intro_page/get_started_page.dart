import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login.dart';
import '../signup.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Column(
              children: [
                const SizedBox(
                  height: 103,
                ),
                SizedBox(
                  width: 265,
                  child: Image.asset('assets/images_onboarding/onboard_page5.png')
                ),
              ],
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 400,
                  ),
                  SizedBox(
                  width: 311,
                  height: 53,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mari Kita Mulai!",
                      textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff101623),
                        ),
                        ),
                      ),
                    ],
                  ),
                          ),
                const SizedBox(
                  height: 17,
                ),
                SizedBox(
                  width: 311,
                  child: Text("Login untuk menikmati fitur yang kami sediakan, dan tetap sehat!",
                  textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff717784),
                    ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff199A8E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xff199A8E)
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffffffff),
                            side: const BorderSide(
                              width: 1.0,
                              color: Color(0xff199A8E)
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                ],
              )
            ],
          )
          ],
        ),
      ),
    );
  }
}