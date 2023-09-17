import 'package:aplikasi_reservasi_dokter_candra_safitri/intro_page/get_started_page.dart';
import 'package:aplikasi_reservasi_dokter_candra_safitri/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'api_controller/pasien_login_controller.dart';

class SignUpPage extends StatefulWidget {
	const SignUpPage({super.key});

	@override
	State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
	final TextEditingController namaLengkapController = TextEditingController();
  late String jenisKelamin;  
	final TextEditingController tanggalLahirController = TextEditingController();
	final TextEditingController noTeleponController= TextEditingController();
	final TextEditingController usernameController = TextEditingController();
	final TextEditingController passwordController = TextEditingController();
	final TextEditingController confirmPasswordController = TextEditingController();
	final GlobalKey<FormState> formKey = GlobalKey<FormState>();
	bool isObscurePassword = true;
  bool isDateTimeHint = true; 
  RegExp nameRegEx = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  RegExp usernameRegEx = RegExp(r'^[a-z A-Z 0-9 _ .]+$');
  RegExp phoneNumberRegEx = RegExp(r'^[0-9 +]+$');

  Pasien pasien = Pasien();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(child: 
			SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
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
                       Navigator.pop(context, MaterialPageRoute(builder: (context) => const GetStartedPage()));
                     },
                     child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xff101623),
                          size: 30),
                   ),
                    
                        Center(
                          child: Text("Sign Up",
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
      
              const SizedBox(
                 height: 70,
               ),
      
              //Nama Lengkap
              TextFormField(
                  controller: namaLengkapController,
                  keyboardType: TextInputType.text,
                  cursorColor: const Color(0xff000000),
                  decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xffF9FAFB),
                  counterStyle: TextStyle(
                    color: Color(0xff000000)
                  ),
                  hintText: "Nama Lengkap",
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
                  validator: (namaLengkapValue) {
                    if (namaLengkapValue!.isEmpty) {
                      return "Nama lengkap tidak boleh kosong!";
                    } else {
                      return null;
                    }
                    },
                    ),
      
              const SizedBox(
                 width: double.infinity,
                 height: 15,
               ),
              
              //Jenis Kelamin
              DropdownSearch<String>(
                 popupProps: const PopupProps.menu(
                     showSelectedItems: true,
                 ),
                 items: ["Laki-laki", "Perempuan"],
                 onChanged:(value) {
                   setState(() {
                     jenisKelamin = value!;
                   });
                 },
                 dropdownDecoratorProps: const DropDownDecoratorProps(
                   baseStyle: TextStyle(color:Color(0xff000000)),
                     dropdownSearchDecoration: InputDecoration(
                         hintText: "Jenis Kelamin",
                         hintStyle: TextStyle(color: Color(0xffA1A8B0)),
                         prefixIcon: Icon(Icons.transgender, color: Color(0xffA1A8B0),),
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
                         
                     ),
                 ),
               ),
      
              const SizedBox(
                 width: double.infinity,
                 height: 15,
               ),

              //Tanggal Lahir
              TextFormField(
                 controller: tanggalLahirController,
                 readOnly: true,
                 onTap: (){
                   _getDateFromUser();
                 },
                 cursorColor: const Color(0xff000000),
                      decoration: InputDecoration(
                   filled: true,
                   fillColor: Color(0xffF9FAFB),
                   counterStyle: TextStyle(
                     color: Color(0xff000000)
                   ),
                   hintText: isDateTimeHint ? "Tanggal Lahir" : tanggalLahirController.text,
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
                   prefixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xffA1A8B0),),
                   suffixIcon: InkWell(
                   onTap: () {
                     setState(() {
                       isDateTimeHint = !isDateTimeHint;
                     });
                     tanggalLahirController.clear();
                   },
                   child: Icon(isDateTimeHint
                     ? Icons.delete
                     : Icons.delete,
                   ),
                   ),
                   suffixIconColor: isDateTimeHint ? Colors.transparent : Colors.red[400],
                    ),
               validator: (tanggalLahirValue) {
                      if (tanggalLahirValue!.isEmpty) {
                        return "Tanggal lahir tidak boleh kosong!";
                      } 
                 else {
                   return null;
                 }
               }
                    ),
      
              const SizedBox(
                 width: double.infinity,
                 height: 15,
               ),

              //Nomor Telepon
              TextFormField(
                      controller: noTeleponController,
                      keyboardType: TextInputType.number,
                      cursorColor: const Color(0xff000000),
                      decoration: const InputDecoration(
                   filled: true,
                   fillColor: Color(0xffF9FAFB),
                   counterStyle: TextStyle(
                     color: Color(0xff000000)
                   ),
                   hintText: "Nomor Telepon",
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
                   prefixIcon: Icon(Icons.phone, color: Color(0xffA1A8B0),)
                    ),
                    validator: (phoneNumberValue) {
                      if (phoneNumberValue!.isEmpty) {
                        return "Nomor telepon tidak boleh kosong!";
                      } else if (phoneNumberValue.length < 10 || phoneNumberValue.length > 15) {
                   return "Nomor telepon tidak valid";
                 } else if (!phoneNumberRegEx.hasMatch(phoneNumberValue)){
                   return "Nomor telepon hanya memuat angka 0-9";
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

              //Username Baru
              TextFormField(
                      controller: usernameController,
                      maxLength: 15,
                      keyboardType: TextInputType.text,
                      cursorColor: const Color(0xff000000),
                      decoration: const InputDecoration(
                   filled: true,
                   fillColor: Color(0xffF9FAFB),
                   counterStyle: TextStyle(
                     color: Color(0xff000000)
                   ),
                   hintText: "Username Baru",
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

              //Password Baru
              TextFormField(
               controller: passwordController,
               cursorColor: const Color(0xff000000),
               obscureText: isObscurePassword,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: const Color(0xffF9FAFB),
                 hintText: "Password Baru",
                 hintStyle: const TextStyle(color: Color(0xffA1A8B0)),
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
                 prefixIcon: const Icon(Icons.lock_outline, color: Color(0xffA1A8B0),),
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
                 suffixIconColor: const Color(0xffA1A8B0),
               ),
               validator: (passwordValue) {
                 if (passwordValue?.isEmpty ?? true) {
                   return "Password tidak boleh kosong!";
                 } else {
                   return null;
                 }
               },
             ),
             
              const SizedBox(
                 width: double.infinity,
                 height: 15,
               ),
      
              //Konfirmasi Password Baru
              TextFormField(
               controller: confirmPasswordController,
               cursorColor: const Color(0xff000000),
               obscureText: isObscurePassword,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: const Color(0xffF9FAFB),
                 hintText: "Konfirmasi Password Baru",
                 hintStyle: const TextStyle(color: Color(0xffA1A8B0)),
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
                 prefixIcon: const Icon(Icons.lock_outline, color: Color(0xffA1A8B0),),
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
                 suffixIconColor: const Color(0xffA1A8B0),
               ),
               validator: (confirmPasswordValue) {
                 if (confirmPasswordValue?.isEmpty ?? true) {
                   return "Password tidak boleh kosong!";
                 } else if (confirmPasswordValue != passwordController.text) {
                   return "Password tidak cocok";
                 } else {
                   return null;
                 }
               },
             ),
      
              const SizedBox(
               height: 80,
             ),
      
              SizedBox(
               width: double.infinity,
               height: 50,
               child: ElevatedButton(
                 onPressed: () async {
                  if(formKey.currentState!.validate()) {
                    //show snackbar to indicate loading
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Processing Data'),
                      backgroundColor: Color(0xff199A8E),
                    ));

                    bool response = await pasien.postData(
                      namaLengkapController.text,
                      jenisKelamin.toString(),
                      tanggalLahirController.text,
                      noTeleponController.text,
                      usernameController.text,
                      passwordController.text
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                         
                    if(response) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Registrasi akun berhasil!'),
                      backgroundColor: Color(0xff199A8E),
                      ));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Registrasi akun gagal, silahkan coba lagi!'),
                      backgroundColor: Colors.red.shade300,
                      ));
                    }                     
                   }
                 },
                 child: Text(
                   "Sign Up",
                   style: GoogleFonts.roboto(
                     textStyle: const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.white
                     ),
                   ),
                 ),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xff199A8E),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30),
                   ),
                 ),
               ),
             ),
      
              const SizedBox(
               height: 10,
             ),
      
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const Text("Sudah Memiliki Akun? "),
                 GestureDetector(
                   child: const Text(
                     "Masuk Sekarang",
                     style: TextStyle(
                         color: Color(0xff199A8E)
                     ),
                    ),
                   onTap: () {
                     // Write Tap Code Here.
                     // Navigator.push(
                     //     context,
                     //     MaterialPageRoute(
                     //       builder: (context) => SignUpScreen(),
                     //     )
                     // );
                   },
                 )
               ],
               ),
              SizedBox(
                height: 30,
               )
                  ],
                ),
           ),
              ),
      ),
      ),
		);
	}

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        locale: const Locale("id", "ID"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2030)
    );
    if(_pickerDate != null ){
      String _selectedDate = DateFormat('yyyy-MM-dd', 'id').format(_pickerDate); 
      setState(() {
        isDateTimeHint = !isDateTimeHint;
        tanggalLahirController.text = _selectedDate;
        print(tanggalLahirController);
      });
    } else {
      print("ERROR");
    }
  }
}