import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:siplah_jpmall/src/resources/order_provider.dart';

class OrderBloc {

  final _provider = OrderProvider();
  PublishSubject<OrderModel> _myOrderList = PublishSubject<OrderModel>();

  Stream<OrderModel> get  myOrderList => _myOrderList.stream;

  getData(String id) async {
    OrderModel event = await _provider.fetchMyOrder(id);
    _myOrderList.sink.add(event);
  }

  dispose(){
    _myOrderList.close();
  }

}