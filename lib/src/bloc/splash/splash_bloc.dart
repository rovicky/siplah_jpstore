import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc {
  ///method ini digunakan untuk mengambil data apakah aplikasi pernah kita buka sebelumnya atau belum, method ini berisi nilai default true,
  Future<bool> getFirstTimeLaunched() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstTime = _sharedPreferences.getBool('isFirstTime');
    return isFirstTime ?? true;
  }

  Future setFirstTimeLaunched() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool('isFirstTime', false);
  }
}