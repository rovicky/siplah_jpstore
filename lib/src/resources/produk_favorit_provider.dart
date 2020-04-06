import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';

import '../models/produk_model.dart';
class ProductFavProvider {

  Future<Products> fetchProducts(String id, {String idProduct = ""}) async {
    final response = await http.post(BaseUrl.base+"sekolah/produk_favorit/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": "" + id,
      "id":idProduct
    });
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Products products = Products.fromJson(data);
      return products;
    }else {
      throw Exception("Connection or Server Error");
    }
  }

  Future<bool> deleteFromFavorite(String id, String iduser) async {
    final response = await http.post(BaseUrl.base+"sekolah/produk_favorit/hapus", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": "" + iduser,
      "id": id
    });
    if(response.statusCode == 200) {
      debugPrint(response.body);
      final data = jsonDecode(response.body);
      print(data['Error']);
      return data['Error'];
//      return products;
    }else {
      throw Exception("Connection or Server Error");
    }
  }

  Future<bool> addToFavorite(String id, String idUser) async {
    final response = await http.post(BaseUrl.base + "sekolah/produk_favorit/tambah", headers: {
      "Content-Type": "application/json",
      "API-App": "siplah_jpmall.id",
      "Api-Key": "4P1_7Pm411_51p114h",
      "API-Token": "575696f2ed816e00edbfa90f917c6f757e5ce05a"
    }, body: jsonEncode({
      'user_id': "" + idUser,
      'produk_id': id,
    }));

    if(response.statusCode == 200){
      final result = jsonDecode(response.body);
      if(result['Error'] || result['Error'] == null){
        return false;
      }else {
        return true;
      }
    }else{
      return false;
    }
  }
}