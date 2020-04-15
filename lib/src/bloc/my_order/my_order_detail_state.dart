import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/ui/sekolah/my_order_detail_page.dart';

abstract class MyOrderDetailState {
  MyOrderDetailPageState createState();
  MyOrderDetailPageState get _state => createState();

  OrderBloc get _bloc => _state.bloc;

  setLoad(String userId, String id) {
    _bloc.getDataDetail(userId, id);
  }
}