import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class HomeProvider{

  Future<ProductModeltwo> fetchJson(String id) async {
    final response = await http.post(BaseUrl.base + "home/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": "" + id,
    });

    if(response.statusCode == 200) {
      ProductModeltwo result = productModeltwoFromJson(response.body);
      return result;
    }else {
      throw Exception("Cant Load, please check your internet connection.");
    }
  }
}