import 'dart:convert';

import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';

class SettingProvider {
  Future<ResultSetting> fetchData() async {
    final response = await http.post(BaseUrl.base + "blog/blog_footer", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    });
    ResultSetting errorResult(String message) => ResultSetting(error: true, pesanSys: message);
    if(response.statusCode == 200){
      final result = resultSettingFromJson(response.body);
      if(!result.error){
        return result;
      }else{
        return errorResult(result.pesanUsr);
      }
    }else{
      return errorResult("Can't Load data");
    }
  }
}