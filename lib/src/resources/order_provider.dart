import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';

class OrderProvider {
  Future<OrderModel> fetchMyOrder(String id) async {
    final response = await http.post(BaseUrl.base + "sekolah/pesanan/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":id
    });
    if(response.statusCode == 200) {
      return orderModelFromJson(response.body);
    }else{
      return null;
    }
  }
}