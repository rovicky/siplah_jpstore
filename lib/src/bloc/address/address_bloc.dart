import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/address_model.dart';
import 'package:siplah_jpmall/src/resources/setting_provider.dart';

class AddressBloc {
  final _provider = SettingProvider();
  PublishSubject<AddressModel> _addressList = PublishSubject<AddressModel>();

  Stream<AddressModel> get adressList => _addressList.stream;

  getData(String id) async {
    AddressModel event = await _provider.fetchAddressList(id);
    _addressList.sink.add(event);
  }

  dispose(){
    _addressList.close();
  }
}