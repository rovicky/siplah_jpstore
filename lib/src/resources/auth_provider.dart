import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/models/mitra_user.dart';
import 'package:siplah_jpmall/src/models/result_user.dart';
import 'package:siplah_jpmall/src/models/sekolah_user.dart';

import 'package:siplah_jpmall/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';

class AuthProvider extends ChangeNotifier {
  String id;
  UserData user;

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

  Future<UserData> getUserInfo() async {
    final String idUser = await getCredential();
    if(idUser == null){
      return null;
    }
    final response = await http.post(BaseUrl.base + "user/profil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":idUser
    });

    final errorResult = UserData(status: "error");
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(!data['Error']) {
        final result = UserData.fromJson(data['Data'][0]);
        user = result;
        notifyListeners();
        return result;
      }else{
        user = errorResult;
        notifyListeners();

        return errorResult;
      }
    }else{
        user = errorResult;
        notifyListeners();
      return errorResult;
    }
  }
  Future<ResultUser> fetchLogin(String email, String password) async {
    final response = await http.post(BaseUrl.base + "user/login", headers: {
      "Content-Type": BaseUrl.headers.contentTypeJson,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: jsonEncode({
      "email":email,
      "password":password
    }));

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
//      print(response.body);
      if(!result['Error']){
        return resultUserFromJson(response.body);
      }else{
        return ResultUser(error: true);
      }
    }else{
      return ResultUser(error: true);
    }
  }

  Future<MitraUser> fetchMitraUser(String id) async {
    final response = await http.post(BaseUrl.base + "user/profil",
      headers: {
        "Content-Type": BaseUrl.headers.contentTypeurlx,
        "API-App": BaseUrl.headers.apiApp,
        "Api-Key": BaseUrl.headers.apiKey,
        "API-Token": BaseUrl.headers.apiToken
      },
      body: {
      "user_id":id
      }
    );
    if(response.statusCode == 200) {
      return mitraUserFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<SekolahUser> fetchSekolahUser(String id) async {
    final response = await http.post(BaseUrl.base + "user/profil",
        headers: {
          "Content-Type": BaseUrl.headers.contentTypeurlx,
          "API-App": BaseUrl.headers.apiApp,
          "Api-Key": BaseUrl.headers.apiKey,
          "API-Token": BaseUrl.headers.apiToken
        },
        body: {
          "user_id":id
        }
    );
    if(response.statusCode == 200) {
      return sekolahUserFromJson(response.body);
    }else{
      return null;
    }
  }
}
