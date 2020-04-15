

import 'package:siplah_jpmall/src/models/setting_detail_model.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';
import '../../src/models/address_model.dart';

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
//      print(response.body);
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

  Future<SettingDetail> fetchBlog(String id) async {
    final response = await http.post(BaseUrl.base + "blog/tampil", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "id":id
    });
    SettingDetail errorResult(String message) => SettingDetail(error: true, pesanSys: message);
    if(response.statusCode == 200){
//      print(response.body);
      final result = settingDetailFromJson(response.body);
      if(!result.error){
        return result;
      }else{
        return errorResult(result.pesanUsr);
      }
    }else{
      return errorResult("Can't Load data");
    }
  }

  Future<AddressModel> fetchAddressList(String userId) async {
    final response = await http.post(BaseUrl.base+"sekolah/alamat_pengiriman/list", headers: {
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "user_id":userId
    });
    if(response.statusCode == 200){
      return addressModelFromJson(response.body);
    }else{
      return null;
    }
  }
}