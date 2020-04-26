import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/ui/payment/payment_page.dart';

abstract class PaymentState {
  PaymentPageState createState();

  PaymentPageState get _state => createState();

  OrderBloc get _oBloc => _state.oBloc;
  AddressBloc get _aBloc => _state.aBloc;

  loadPayment(String id, String paymentId) {
    _oBloc.getPayment(id, paymentId);
  }

  loadAddress(String userId) {
    _aBloc.getData(userId);
  }

  purchase({List<Map<String, dynamic>> payment,
    List<Map<String, dynamic>> courier,
    List<Map<String, dynamic>> marketing,
    String transactionId,
    Map<String, dynamic> detail}) async {
    if(await _oBloc.purchase(
      transactionId: transactionId, payment: payment,marketing: marketing, detail: detail, courier: courier
    )) {
      print("berhasil");
    }
    print("Failed");
  }

//  Future<CostModel> loadCost(Map<String, dynamic> data) async {
//    return Future.value(_rjBloc.getCost(data));
//  }
}