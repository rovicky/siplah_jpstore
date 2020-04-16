import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class CartProvider {
  Future<CartModel> fetchData(String id) async {
    final response =
        await http.post(BaseUrl.base + "sekolah/keranjang/isi", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": "" + id,
    });
    if (response.statusCode == 200) {
      CartModel cartModel = cartModelFromJson(response.body);
      return cartModel;
    } else {
      throw Exception("Connection or Server Error");
    }
  }

  Future<bool> delete(String id, String userId) async {
    final response =
        await http.post(BaseUrl.base + "sekolah/keranjang/delete", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": "" + userId,
      "id": id
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      debugPrint(result.toString());
      if (!result['Error']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
//      throw Exception("Connection or Server Error");
    }
  }

  Future<bool> postCart(String userId, String mitraId, String produkId, {int jumlah = 1}) async {
    final response =
    await http.post(BaseUrl.base + "sekolah/keranjang/tambah", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id": userId,
      "produk_id": produkId,
      "penjual_user_id":mitraId,
      "jumlah":jumlah.toString()
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      debugPrint(result.toString());
      if (!result['Error']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
//      throw Exception("Connection or Server Error");
    }
  }
  Future<bool> setQty(String id, {int jumlah = 1}) async {
    final response =
    await http.post(BaseUrl.base + "sekolah/keranjang/set_stok", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "id":id,
      "jumlah": jumlah.toString()
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      debugPrint(result.toString());
      if (!result['Error']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
//      throw Exception("Connection or Server Error");
    }
  }

}
