import 'package:aplikasi_reservasi_dokter_candra_safitri/features/auth/presentation/cubit/obscure_password_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SignUpTextField extends StatelessWidget {
  SignUpTextField(
      {super.key,
      required this.namaLengkapController,
      required this.tanggalLahirController,
      required this.noTeleponController,
      required this.usernameController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.jenisKelamin,
      required this.obscurePasswordCubit});

  final TextEditingController namaLengkapController;
  final TextEditingController tanggalLahirController;
  final TextEditingController noTeleponController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final ValueNotifier jenisKelamin;
  final ValueNotifier<bool> isDateTimeHint = ValueNotifier(true);

  final ObscurePasswordCubit obscurePasswordCubit;

  final RegExp nameRegEx =
      RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  final RegExp usernameRegEx = RegExp(r'^[a-z A-Z 0-9 _ .]+$');
  final RegExp phoneNumberRegEx = RegExp(r'^[0-9 +]+$');

  @override
  Widget build(BuildContext context) {
    getDateFromUser() async {
      DateTime? pickerDate = await showDatePicker(
          context: context,
          locale: const Locale("id", "ID"),
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2030));
      if (pickerDate != null) {
        String selectedDate = DateFormat('yyyy-MM-dd', 'id').format(pickerDate);
        isDateTimeHint.value = !isDateTimeHint.value;
        tanggalLahirController.text = selectedDate;
        print(tanggalLahirController);
      } else {
        print("ERROR");
      }
    }

    return Column(
      children: [
        //Nama Lengkap
        TextFormField(
          controller: namaLengkapController,
          keyboardType: TextInputType.text,
          cursorColor: const Color(0xff000000),
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffF9FAFB),
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xffA1A8B0),
              )),
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
          items: const ["Laki-laki", "Perempuan"],
          onChanged: (value) {
            jenisKelamin.value = value!;
          },
          dropdownDecoratorProps: const DropDownDecoratorProps(
            baseStyle: TextStyle(color: Color(0xff000000)),
            dropdownSearchDecoration: InputDecoration(
              hintText: "Jenis Kelamin",
              hintStyle: TextStyle(color: Color(0xffA1A8B0)),
              prefixIcon: Icon(
                Icons.transgender,
                color: Color(0xffA1A8B0),
              ),
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
          validator: (jenisKelaminValue) {
            if (jenisKelaminValue == null) {
              return "Jenis Kelamin tidak boleh kosong!";
            } else {
              return null;
            }
          },
        ),

        const SizedBox(
          width: double.infinity,
          height: 15,
        ),

        //Tanggal Lahir
        TextFormField(
            controller: tanggalLahirController,
            readOnly: true,
            onTap: () {
              getDateFromUser();
            },
            cursorColor: const Color(0xff000000),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF9FAFB),
              counterStyle: const TextStyle(color: Color(0xff000000)),
              hintText: isDateTimeHint.value
                  ? "Tanggal Lahir"
                  : tanggalLahirController.text,
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
              prefixIcon: const Icon(
                Icons.calendar_today_outlined,
                color: Color(0xffA1A8B0),
              ),
            ),
            validator: (tanggalLahirValue) {
              if (tanggalLahirValue!.isEmpty) {
                return "Tanggal lahir tidak boleh kosong!";
              } else {
                return null;
              }
            }),

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
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.phone,
                color: Color(0xffA1A8B0),
              )),
          validator: (phoneNumberValue) {
            if (phoneNumberValue!.isEmpty) {
              return "Nomor telepon tidak boleh kosong!";
            } else if (phoneNumberValue.length < 10 ||
                phoneNumberValue.length > 15) {
              return "Nomor telepon tidak valid";
            } else if (!phoneNumberRegEx.hasMatch(phoneNumberValue)) {
              return "Nomor telepon hanya memuat angka 0-9";
            } else {
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
              counterStyle: TextStyle(color: Color(0xff000000)),
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
              prefixIcon: Icon(
                Icons.person_outline,
                color: Color(0xffA1A8B0),
              )),
          validator: (usernameValue) {
            if (usernameValue!.isEmpty) {
              return "Username tidak boleh kosong!";
            } else if (usernameValue.length < 4) {
              return "Username tidak boleh kurang dari 4 karakter!";
            } else if (!usernameRegEx.hasMatch(usernameValue)) {
              return "Username hanya memuat huruf (a-z) angka (0-9) \ntitik (.) dan underscore (_)";
            } else {
              return null;
            }
          },
        ),

        const SizedBox(
          width: double.infinity,
          height: 15,
        ),

        //Password Baru
        BlocBuilder<ObscurePasswordCubit, ObscurePasswordState>(
          bloc: obscurePasswordCubit,
          builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              cursorColor: const Color(0xff000000),
              obscureText: state is ObscurePasswordOn,
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
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Color(0xffA1A8B0),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (state is ObscurePasswordOff) {
                      obscurePasswordCubit.hidePassword();
                    } else if (state is ObscurePasswordOn) {
                      obscurePasswordCubit.showPassword();
                    }
                  },
                  child: Icon(
                    state is ObscurePasswordOn
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
            );
          },
        ),

        const SizedBox(
          width: double.infinity,
          height: 15,
        ),

        //Konfirmasi Password Baru
        BlocBuilder<ObscurePasswordCubit, ObscurePasswordState>(
          bloc: obscurePasswordCubit,
          builder: (context, state) {
            return TextFormField(
              controller: confirmPasswordController,
              cursorColor: const Color(0xff000000),
              obscureText: state is ObscurePasswordOn,
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
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: Color(0xffA1A8B0),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (state is ObscurePasswordOff) {
                      obscurePasswordCubit.hidePassword();
                    } else if (state is ObscurePasswordOn) {
                      obscurePasswordCubit.showPassword();
                    }
                  },
                  child: Icon(
                    state is ObscurePasswordOn
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
            );
          },
        ),
      ],
    );
  }
}
