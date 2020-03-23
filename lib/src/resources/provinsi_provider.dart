import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' show Client;
import 'package:siplah_jpmall/src/models/get_token.dart';
import 'package:siplah_jpmall/src/models/provinsi_model.dart';
import 'package:siplah_jpmall/src/utils/base_url.dart';

class ProvinceProvider {
  Client client = Client();
  final url = BaseUrl.base + "domisili/get_provinsi";
  Future<Province> province() async {
    final response = await client.post(
      url,
      headers: {
        "Content-Type": BaseUrl.headers.contentTypeJson,
        "API-App": BaseUrl.headers.apiApp,
        "Api-Key": BaseUrl.headers.apiKey,
        "API-Token": BaseUrl.headers.apiToken
      },
    );
    if (response.statusCode == 200) {
      return compute(provinceFromJson, response.body);
    } else {
      throw Exception("Failed to Load");
    }
  }
}
