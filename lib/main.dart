import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/login.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
String? idPasien = "";

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  SharedPreferences pref = await SharedPreferences.getInstance();
  idPasien = pref.getString("idPasien");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isViewed != 0 ? OnBoardingScreen() : idPasien != null ? LoginPage() : GetStartedPage(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [
      const Locale('id', 'ID'), // Indonesian
      ]
    );
  }
}