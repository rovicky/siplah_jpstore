import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/kabupaten_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class KabupatenProvider{
  Client client = Client();
  final url = BaseUrl.base + "domisili/get_kabupaten";
  Future<Kabupaten> kabupaten(provId) async {
    final response = await client.post(url, 
      headers: {"Content-Type": BaseUrl.headers.contentTypeurlx,"API-App":BaseUrl.headers.apiApp,"Api-Key":BaseUrl.headers.apiKey,"API-Token":BaseUrl.headers.apiToken},
    body: {
    
       "provinsi_id":provId
    });
    if(response.statusCode == 200){
      return compute(kabupatenFromJson, response.body);
    }else{
      throw Exception("Failed to Loaad");
    }
  }
}