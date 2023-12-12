import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingStore {
  static const _onBoardKey = "onBoard";

  static Future<void> storeOnBoardInfo(int isViewed) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setInt(_onBoardKey, isViewed);
  }

  static Future<int?> getOnBoardInfo() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getInt(_onBoardKey);
  }
}

class LoginDataStore {
  static const _idPasien = "idPasien";
  static const _namaPasien = "namaPasien";
  static const _jenisKelamin = "jenisKelamin";
  static const _tanggalLahir = "tanggalLahir";
  static const _noTelepon = "noTelepon";
  static const _fotoPasien = "fotoPasien";
  static const _username = "username";

  static Future<void> storeLoginInfo(
      String idPasien,
      String namaPasien,
      String jenisKelamin,
      String tanggalLahir,
      String noTelepon,
      String fotoPasien,
      String username) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setString(_idPasien, idPasien);
    await preference.setString(_namaPasien, namaPasien);
    await preference.setString(_jenisKelamin, jenisKelamin);
    await preference.setString(_tanggalLahir, tanggalLahir);
    await preference.setString(_noTelepon, noTelepon);
    await preference.setString(_fotoPasien, fotoPasien);
    await preference.setString(_username, username);
  }

  static Future<String?> getIdPasien() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_idPasien);
  }

  static Future<String?> getNamaPasien() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_namaPasien);
  }

  static Future<String?> getJenisKelamin() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_jenisKelamin);
  }

  static Future<String?> getTanggalLahir() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_tanggalLahir);
  }

  static Future<String?> getNoTelepon() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_noTelepon);
  }

  static Future<String?> getFotoPasien() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_fotoPasien);
  }

  static Future<String?> getUsername() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getString(_username);
  }

  static Future<void> clearLoginInfo() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_idPasien);
    await pref.remove(_namaPasien);
    await pref.remove(_jenisKelamin);
    await pref.remove(_tanggalLahir);
    await pref.remove(_noTelepon);
    await pref.remove(_fotoPasien);
    await pref.remove(_username);
  }
}
