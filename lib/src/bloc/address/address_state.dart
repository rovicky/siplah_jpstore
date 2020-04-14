import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/ui/auth/address_list_page.dart';

abstract class AddressState{
  AddressListPageState createState();
  AddressListPageState get _state => createState();

  AddressBloc get _bloc => _state.bloc;

  firstLoad(String id) {
    _bloc.getData(id);
  }
}