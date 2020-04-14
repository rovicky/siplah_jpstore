import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/ui/sekolah/my_order_page.dart';

abstract class MyOrderState {
  MyOrderPageState createState();

  MyOrderPageState get _state => createState();

  OrderBloc get _bloc => _state.bloc;

  setLoad(String id) {
    _bloc.getData(id);
  }
}