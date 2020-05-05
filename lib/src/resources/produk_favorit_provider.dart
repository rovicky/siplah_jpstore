import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';

import '../models/produk_model.dart';
class ProductFavProvider {

  Future<Products> fetchProducts(String id, {String idProduct = ""}) async {
    print(id + "-"+ idProduct);
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
      print(response.body);
      final data = jsonDecode(response.body);
      Products products = Products.fromJson(data);
      return products;
    }else {
      throw Exception("Connection or Server Error");
    }
  }

  Future<bool> deleteFromFavorite(String id, String iduser) async {
    print(id+"-"+iduser);
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
      final data = jsonDecode(response.body);
      print(data['Error']);
      return data['Error'];
//      return products;
    }else {
      return false;
    }
  }

  Future<bool> addToFavorite(String id, String idUser) async {
    final response = await http.post(BaseUrl.base + "sekolah/produk_favorit/tambah", headers: {
      "Content-Type": BaseUrl.headers.contentTypeJson,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: jsonEncode({
      'user_id': "" + idUser,
      'produk_id': id,
    }));

    if(response.statusCode == 200){
      print(response.body);
      final result = jsonDecode(response.body);
      return result['Error'];
    }else{
      return false;
    }
  }
}