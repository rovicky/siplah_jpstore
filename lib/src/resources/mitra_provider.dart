import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class MitraDetailProvider {
  Future<MitraDetailModel> getMitra(String mitraId) async {
    final response = await http.post(BaseUrl.base + "user/profil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": mitraId
    });
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return MitraDetailModel.fromJson(result);
    }else{
      return null;
    }
  }

}
