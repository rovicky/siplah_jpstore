import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/product_detail.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
//import '';

class ProductProvider {
  Client client = Client();
  final url = BaseUrl.base;
  Future<ProductModeltwo> fetchProducts({String id = '', String mitraId = '', String categoryId = ''}) async {
    final response = await client.post(
      url + "home/list",
      headers: {
        "Content-Type": BaseUrl.headers.contentTypeurlx,
        "API-App": BaseUrl.headers.apiApp,
        "Api-Key": BaseUrl.headers.apiKey,
        "API-Token": BaseUrl.headers.apiToken
      },
      body: {
        "user_id":id ?? '',
        "mitra_id":mitraId ?? '',
        "category_id":categoryId ?? '',
//        "produk_lainnya":true
      }
    );
    if (response.statusCode == 200) {
      final ProductModeltwo result = ProductModeltwo.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception("Failed to Load");
    }
  }

  Future<ProductDetail> fetchProduct(String id, String userId) async {
    final response = await client.post(url + "produk/detail", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":userId ?? '',
      "id":id ?? ''
    });

    if(response.statusCode == 200){
      //0 = produk tidak ada tetapi tidak error
      //00 = error
      final result = jsonDecode(response.body);
      debugPrint(response.body);
      if(result['Error']){
        return ProductDetail(id: "00");
      }else if(result['Data'] == null){
        return ProductDetail(id: "0");
      }else{
        return ProductDetail.fromJson(result['Data'][0]);
      }
    }else {
        return ProductDetail(id: "00");
    }
  }
}
