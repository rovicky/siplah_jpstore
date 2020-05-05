import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/category_model.dart';
import 'package:siplah_jpmall/src/models/marketing_model.dart';
import 'package:siplah_jpmall/src/models/mitra/cabang_model.dart';
import 'package:siplah_jpmall/src/models/mitra/order_in_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra/products_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/models/mitra_list_model.dart';
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

  Future<MitraListModel> getMitras() async {
    final response = await http.post(BaseUrl.base + "admin/data_mitra/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    });
    if(response.statusCode == 200) {
      return mitraListModelFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<MarketingModel> fetchMarketing(String mitraId) async {
    final response = await http.post(BaseUrl.base + "mitra/marketing/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":mitraId
    });

    if(response.statusCode == 200) {
      return marketingModelFromJson(response.body);
    }else {
      return null;
    }
  }

  Future<OrderInMitra> fetchMitraOrder(String mitraId, {int limit = 10, int page = 1}) async {
    final response = await http.post(BaseUrl.base + "mitra/penjualan/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":mitraId,
    });

    print(response.body);

    if(response.statusCode == 200) {
      return orderInMitraFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<ProductsMitra> fetchProductsInMitra(String mitraId, {int length = 10, int start = 0}) async {
    final response = await http.post(BaseUrl.base + "mitra/produk/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":mitraId,
      "length":length.toString(),
      "start":start.toString()
    });

    if(response.statusCode == 200) {
      return productsMitraFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<Map<String, dynamic>> updateStock(String mitraId, String productId, {int stock}) async {
    final response = await http.post(BaseUrl.base + "mitra/produk/update_stok", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":mitraId,
      "stok":stock ?? '',
      "id":productId
    });

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }
  ///terdapat beberapa mode untuk create produk mitra yaitu 0 untuk create dan 1 untuk update
  Future<Map<String,dynamic>> createProductMitra(ProductMitraModel productMitraModel, {int mode = 0}) async {
    final response = await http.post((mode == 0) ? BaseUrl.base + "mitra/produk/add" : BaseUrl.base + "mitra/produk/update", headers: {
      "Content-Type": BaseUrl.headers.contentTypeJson,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: jsonEncode(productMitraModel.toJson()));

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  Future<Map<String, dynamic>> createMarketing(Marketing marketing, {int mode = 0}) async {
    final response = await http.post((mode == 0) ? BaseUrl.base + "mitra/marketing/tambah" : BaseUrl.base + "mitra/marketing/edit", headers: {
      "Content-Type": BaseUrl.headers.contentTypeJson,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: jsonEncode(marketing.toJson()));

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  Future<CabangModel> fetchCabangMitra(String mitraId, {int length = 10, int start = 0}) async {
    print("mitra id = $mitraId");
    final response = await http.post(BaseUrl.base + "mitra/cabang/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":mitraId,
    });

    if(response.statusCode == 200) {
      print("response : "+response.body);
      return cabangModelFromJson(response.body);
    }else{
      throw Exception("Failed to Load Data");
    }
  }

  Future<Map<String, dynamic>> createCabangMitra(Cabang cabang, {int mode = 0}) async {
    final response = await http.post((mode == 0) ? BaseUrl.base + "mitra/cabang/add" : BaseUrl.base + "mitra/cabang/update", headers: {
      "Content-Type": BaseUrl.headers.contentTypeJson,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: jsonEncode(cabang.toJson()));

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  Future<Map<String, dynamic>> deleteCabangMitra(String idCabang) async {
    final response = await http.post(BaseUrl.base + "mitra/cabang/delete", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "id":idCabang
    });

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }else {
      return null;
    }
  }

  Future<Map<String, dynamic>> deleteMarketing(String mitraId, String id) async {
    final response = await http.post(BaseUrl.base + "mitra/marketing/hapus", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "id":id,
      "user_id": mitraId
    });

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<CategoryModel> fetchCategory() async {
    final response = await http.post(BaseUrl.base + "mitra/kategori/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    });

    if(response.statusCode == 200) {
      return categoryModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
