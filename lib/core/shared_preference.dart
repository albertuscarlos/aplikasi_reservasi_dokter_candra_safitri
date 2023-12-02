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
