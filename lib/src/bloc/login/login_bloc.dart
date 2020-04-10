import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/models/result_user.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';

class LoginBloc {
  final _provider = AuthProvider();

  Future<ResultUser> getLogin(String email, String password) async {
    final ResultUser resultUser = await _provider.fetchLogin(email, password);
    return resultUser;
  }

  Future<bool> setIdPreferences(String id) async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    final bool result = await _sharedPreferences.setString("id", id);
    return result;
  }

}