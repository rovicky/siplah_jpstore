import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/models/user.dart';

class AuthProvider extends ChangeNotifier {
  String id;
  User user;

  Future<String> getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _id = sharedPreferences.getString('id');
    if (_id != null) {
      id = _id;
      notifyListeners();
      return id;
    } else {
      return id;
    }
  }

  Future<User> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _id = sharedPreferences.getString('id');
    String _name = sharedPreferences.getString('name');
    String _levelId = sharedPreferences.getString('level_id');
    String _photo = sharedPreferences.getString('foto');
    String _username = sharedPreferences.getString('username');

    if (_id != null) {
      User _user = User(
          id: _id,
          levelId: _levelId,
          name: _name,
          photo: _photo,
          username: _username);

      user = _user;
      notifyListeners();
      return _user;
    } else {
      return user;
    }
  }
}
