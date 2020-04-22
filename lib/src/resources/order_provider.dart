import 'dart:convert';

import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/payment_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class OrderProvider {
  Future<OrderModel> fetchMyOrder(String userId, {String id}) async {
    final response = await http.post(BaseUrl.base + "sekolah/pesanan/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":userId,
      "id":id ?? ''
    });
    if(response.statusCode == 200) {
      return orderModelFromJson(response.body);
    }else{
      return null;
    }
  }

  Future<Map<String, dynamic>> createPayment(String idUser, List<String> ids) async {
    List<Map<String, dynamic>> keranjangId = List.generate(ids.length, (index) => {"id": ids[index]});
    print(keranjangId.toString());
    final response = await http.post(BaseUrl.base + "sekolah/pembayaran/tambah", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":idUser,
      "keranjang_id": jsonEncode(keranjangId)
    });
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }else{
      return null;
    }
  }

  Future<PaymentModel> fetchPayment(String userId, String paymentId) async {
    final response = await http.post(BaseUrl.base + "sekolah/pembayaran/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":userId,
      "transaksi_id":paymentId
    });
    if(response.statusCode == 200) {
      return paymentModelFromJson(response.body);
    }else{
      return null;
    }
  }
}