import 'package:siplah_jpmall/src/models/address/district_model.dart';
import 'package:siplah_jpmall/src/models/address/sub_district_model.dart';
import 'package:siplah_jpmall/src/models/address/province_model.dart';
import 'package:http/http.dart' as http;
import 'package:siplah_jpmall/src/utils/base_url.dart';

class AddressProvider {

  Future<ProvinceModel> fetchProvince() async {
    final response = await http.post(BaseUrl.base + "domisili/get_provinsi", headers:{
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    });

    if(response.statusCode == 200) {
      return provinceModelFromJson(response.body);
    }else {
      return null;
    }
  }

  Future<DistrictModel> fetchDistrict(String provinceId) async {
    final response = await http.post(BaseUrl.base + "domisili/get_kabupaten", headers:{
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "provinsi_id":provinceId
    });

    if(response.statusCode == 200) {
      return districtModelFromJson(response.body);
    }else {
      return null;
    }
  }

  Future<SubDistrictModel> fetchSubDistrict(String provinceId, String districtId) async {
    final response = await http.post(BaseUrl.base + "domisili/get_kecamatan", headers:{
      "Content-Type": BaseUrl.headers.contentTypeurlx,
      "API-App": BaseUrl.headers.apiApp,
      "Api-Key": BaseUrl.headers.apiKey,
      "API-Token": BaseUrl.headers.apiToken
    }, body: {
      "provinsi_id":provinceId,
      "kabupaten_id":districtId
    });

    if(response.statusCode == 200) {
      return subDistrictModelFromJson(response.body);
    }else {
      return null;
    }
  }
}