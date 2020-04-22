import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/models/cost_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class RajaOngkirProvider {

  Future<CostModel> fetchCost(Map<String, dynamic> data) async {
    /**
     * data =
     * 1. destination,
     * 2. origin
     * 3. weight
     */

    print(data);
    final response = await http.post(BaseUrl.rjUrl + "cost", headers: {
      "key":BaseUrl.headers.rjKey
    }, body: {
      "destination":data['destination'].toString(),
      "destinationType":"subdistrict",
      "origin":data['origin'].toString(),
      "originType":"subdistrict",
      "weight":data['weight'].toString(),
      "courier":BaseUrl.headers.courierProvider
    });

    if(response.statusCode == 200) {
    print(response.body);
      return costModelFromJson(response.body);
    }else{
      return null;
    }
  }

}