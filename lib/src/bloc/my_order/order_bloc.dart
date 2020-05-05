import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/order_model.dart';
import 'package:siplah_jpmall/src/models/payment_model.dart';
import 'package:siplah_jpmall/src/resources/order_provider.dart';

class OrderBloc {
  final _provider = OrderProvider();
  PublishSubject<OrderModel> _myOrderList = PublishSubject<OrderModel>();
  PublishSubject<OrderModel> _myOrder = PublishSubject<OrderModel>();
  PublishSubject<PaymentModel> _payment = PublishSubject<PaymentModel>();

  Stream<OrderModel> get myOrderList => _myOrderList.stream;
  Stream<OrderModel> get myOrder => _myOrder.stream;
  Stream<PaymentModel> get payment => _payment.stream;

  getData(String id) async {
    OrderModel event = await _provider.fetchMyOrder(id);
    _myOrderList.sink.add(event);
  }

  Future<bool> purchase(
      {List<Map<String, dynamic>> payment,
      List<Map<String, dynamic>> courier,
      List<Map<String, dynamic>> marketing,
      String transactionId,
      Map<String, dynamic> detail}) async {
    return Future.value(_provider.purchaseOrder(
        courier: courier,
        detail: detail,
        marketing: marketing,
        payment: payment,
        transactionId: transactionId));
  }

  getDataDetail(String userId, String id) async {
    OrderModel event = await _provider.fetchMyOrder(userId, id: id);
    _myOrder.sink.add(event);
  }

  getPayment(String userId, String paymentId) async {
    PaymentModel event = await _provider.fetchPayment(userId, paymentId);
    _payment.sink.add(event);
  }

  Future<String> getToken() => _provider.fetchToken();

  dispose() {
    _myOrderList.close();
    _myOrder.close();
    _payment.close();
  }
}
