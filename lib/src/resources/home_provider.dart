import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/recomened_products_model.dart';
import 'package:siplah_jpmall/src/models/slide_model.dart';
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

  Future<RecomendedProducts> fetchrp(String userId, {int limit = 10, int page = 1,}) async {
    final response = await http.post(BaseUrl.base + "home/rekomendasi", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": userId,
      "page": page.toString(),
      "limit":limit.toString()
    });

    if(response.statusCode == 200) {
      RecomendedProducts result = recomendedProductsFromJson(response.body);
      return result;
    }else {
      return null;
    }
  }

  Future<SlideModel> fetchSlide() async {
    final response = await http.post(BaseUrl.base + "admin/data_slide/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    });

    if(response.statusCode == 200) {
      SlideModel result = slideModelFromJson(response.body);
      return result;
    }else {
      return null;
    }
  }


}