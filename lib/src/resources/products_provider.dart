import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart';
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/product_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';
//import '';

class ProductProvider{
  Client client = Client();
  final url = BaseUrl.base + "home/list";
  Future<List<Products>> fetchProducts() async {
    final response = await client.get(url,headers: {"Content-Type": BaseUrl.headers.contentTypeurlx,"API-App":BaseUrl.headers.apiApp,"Api-Key":BaseUrl.headers.apiKey,"API-Token":BaseUrl.headers.apiToken},);
    if(response.statusCode == 200){
      return compute(productsFromJson, response.body);
    }else{
      throw Exception("Failed to Load");
    }
  }
}