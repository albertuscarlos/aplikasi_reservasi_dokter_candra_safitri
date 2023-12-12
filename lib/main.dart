import 'package:aplikasi_reservasi_dokter_candra_safitri/core/shared_preference.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/navbar/presentation/pages/navbar.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/onboarding/presentation/pages/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

int? isViewed;
String? idPasien = "";

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  isViewed = await OnBoardingStore.getOnBoardInfo();
  idPasien = await LoginDataStore.getIdPasien();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: isViewed != 0
            ? OnBoardingScreen()
            : idPasien != null
                ? const NavBar()
                : const GetStartedPage(),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('id', 'ID'), // Indonesian
        ]);
  }
}
