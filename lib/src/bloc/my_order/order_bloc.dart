import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:siplah_jpmall/src/resources/order_provider.dart';

class OrderBloc {

  final _provider = OrderProvider();
  PublishSubject<OrderModel> _myOrderList = PublishSubject<OrderModel>();
  PublishSubject<OrderModel> _myOrder = PublishSubject<OrderModel>();

  Stream<OrderModel> get  myOrderList => _myOrderList.stream;
  Stream<OrderModel> get  myOrder => _myOrder.stream;

  getData(String id) async {
    OrderModel event = await _provider.fetchMyOrder(id);
    _myOrderList.sink.add(event);
  }

  getDataDetail(String userId, String id) async {
    OrderModel event = await _provider.fetchMyOrder(userId, id: id);
    _myOrder.sink.add(event);
  }

  dispose(){
    _myOrderList.close();
    _myOrder.close();
  }

}