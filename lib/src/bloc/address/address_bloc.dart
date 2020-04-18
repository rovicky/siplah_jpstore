import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/address/district_model.dart';
import 'package:siplah_jpmall/src/models/address/province_model.dart';
import 'package:siplah_jpmall/src/models/address/sub_district_model.dart';
import 'package:siplah_jpmall/src/models/address_model.dart';
import 'package:siplah_jpmall/src/resources/address_provider.dart';
import 'package:siplah_jpmall/src/resources/setting_provider.dart';

class AddressBloc {
  final _provider = SettingProvider();
  final _addressProvider = AddressProvider();
  PublishSubject<AddressModel> _addressList = PublishSubject<AddressModel>();
  PublishSubject<ProvinceModel> _province = PublishSubject<ProvinceModel>();
  PublishSubject<DistrictModel> _district = PublishSubject<DistrictModel>();
  PublishSubject<SubDistrictModel> _subDistrict = PublishSubject<SubDistrictModel>();

  Stream<AddressModel> get adressList => _addressList.stream;
  Stream<ProvinceModel> get province => _province.stream;
  Stream<DistrictModel> get district => _district.stream;
  Stream<SubDistrictModel> get subDistrict => _subDistrict.stream;

  getData(String id) async {
    AddressModel event = await _provider.fetchAddressList(id);
    _addressList.sink.add(event);
  }

  getProvince() async {
    ProvinceModel event = await _addressProvider.fetchProvince();
    _province.sink.add(event);
  }

  getDistrict(String provinceId) async {
    DistrictModel event = await _addressProvider.fetchDistrict(provinceId);
    _district.sink.add(event);
  }

  getSubDistrict(String provinceId, String districtId) async {
    SubDistrictModel event = await _addressProvider.fetchSubDistrict(provinceId, districtId);
    _subDistrict.sink.add(event);
  }

  dispose(){
    _addressList.close();
    _district.close();
    _subDistrict.close();
    _province.close();
  }
}