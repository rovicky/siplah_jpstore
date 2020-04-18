import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/ui/pick_address_page.dart';

abstract class PickAddressState {
  PickAddressPageState createState();
  PickAddressPageState get _state => createState();

  AddressBloc get _bloc => _state.bloc;

  loadProvince() async {
    _bloc.getProvince();
  }
  loadDistrict(String provinceId) async {
    _bloc.getDistrict(provinceId);
  }
  loadSubDistrict(String provinceId, String districtId) async {
    _bloc.getSubDistrict(provinceId, districtId);
  }


}