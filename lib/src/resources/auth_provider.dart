import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String id;

  Future<String> getCredential() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String _id = sharedPreferences.getString('id');
    if(_id != null){
      id = _id;
      notifyListeners();
      return id;
    }else {
      return id;
    }
  }
}