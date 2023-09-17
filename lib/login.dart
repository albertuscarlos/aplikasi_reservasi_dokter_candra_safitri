import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'api_controller/pasien_login_controller.dart';

class LoginPage extends StatefulWidget {
	const LoginPage({super.key});

	@override
	State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	final TextEditingController usernameController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();
	final GlobalKey<FormState> formKey = GlobalKey<FormState>();
	bool isObscurePassword = true;
  RegExp usernameRegEx = RegExp(r'^[a-z A-Z 0-9 _ .]+$');

  Pasien pasien = Pasien();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? valIdPasien = pref.getString("idPasien");
    if (valIdPasien != null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(idPasien: valIdPasien,)),(route) => false);
    }
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(child: 
			Container(
				margin: EdgeInsets.only(left: 20, right: 20),
				child: Form(
          key: formKey,
          child: Column(
					children: [
						const SizedBox(
							height: 30,
						),

						Stack(
							children: [
								GestureDetector(
                  onTap: () {
                    Navigator.pop(context, MaterialPageRoute(builder: (context) => GetStartedPage()));
                  },
                  child: Icon(
									Icons.arrow_back_ios_new,
									color: Color(0xff101623),
									size: 30),
                ),
						
								Center(
									child: Text("Login",
										style: GoogleFonts.inter(
										textStyle: const TextStyle(
											fontSize: 25,
											fontWeight: FontWeight.bold,
											color: Color(0xff101623),
										),
										),
									),
								),
							],
						),

            SizedBox(
              height: 70,
            ),

						TextFormField(
							controller: usernameController,
							maxLength: 15,
							keyboardType: TextInputType.text,
							cursorColor: Color(0xff000000),
							decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffF9FAFB),
                counterStyle: TextStyle(
                  color: Color(0xff000000)
                ),
                hintText: "Masukkan username anda",
                hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xffE5E7EB),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Color(0xffE5E7EB),
                  ),
                ),
                prefixIcon: Icon(Icons.person_outline, color: Color(0xffA1A8B0),)
						),
						validator: (usernameValue) {
							if (usernameValue!.isEmpty) {
								return "Username tidak boleh kosong!";
							} else if (usernameValue.length < 4) {
                return "Username tidak boleh kurang dari 4 karakter!";
              } else if (!usernameRegEx.hasMatch(usernameValue)){
                return "Username hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
              }
              else {
                return null;
              }
							
						},
					),

          const SizedBox(
            width: double.infinity,
            height: 15,
          ),

          //Form Input Password
          TextFormField(
            controller: passwordController,
            cursorColor: Color(0xff000000),
            obscureText: isObscurePassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xffF9FAFB),
              hintText: "Masukkan password anda",
              hintStyle: TextStyle(color: Color(0xffA1A8B0)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Color(0xffE5E7EB),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Color(0xffE5E7EB),
                ),
              ),
              prefixIcon: Icon(Icons.lock_outline, color: Color(0xffA1A8B0),),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
                child: Icon(isObscurePassword
                  ? Icons.visibility
                  : Icons.visibility_off,
                ),
              ),
              suffixIconColor: Color(0xffA1A8B0),
            ),
            validator: (passValue) {
              if (passValue?.isEmpty ?? true) {
                return "Password tidak boleh kosong!";
              }
              return null;
            },
          ),

          SizedBox(
            height: 80,
          ),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if(formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Processing Data'),
                      backgroundColor: Color(0xff199A8E),
                  ));

                  pasien.postLogin(
                          usernameController.text,
                          passwordController.text, ).then((value) => {
                      if(value != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Login berhasil!'),
                        backgroundColor: Color(0xff199A8E),
                        )),

                        pageRoute(value[0]['id_pasien'], value[0]['nama_lengkap'], value[0]['jenis_kelamin'], value[0]['tanggal_lahir'], value[0]['no_telepon'], value[0]['username'], value[0]['password'])
                       }
                      else if (value == null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Login gagal, silahkan coba lagi!'),
                        backgroundColor: Colors.red.shade300,
                      )),
                      }
                  });
                }
              },
              child: Text(
                "Login",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff199A8E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Belum Memiliki Akun? "),
              GestureDetector(
                child: Text(
                  "Registrasi Sekarang",
                  style: TextStyle(
                      color: Color(0xff199A8E)
                  ),
                 ),
                onTap: () {
                  //Write Tap Code Here.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      )
                  );
                },
              )
            ],
            ),
					],
				),
        ),
			),
      ),
		);
	}

  void pageRoute(String idPasien, String namaPasien, String jenisKelamin, String tanggalLahir, String noTelepon, String username, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("idPasien", idPasien);
    await pref.setString("namaPasien", namaPasien);
    await pref.setString("jenisKelamin", jenisKelamin);
    await pref.setString("tanggalLahir", tanggalLahir);
    await pref.setString("noTelepon", noTelepon);
    await pref.setString("username", username);
    await pref.setString("password", password);

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(idPasien: idPasien,)),(route) => false);
  }
}