import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/bloc/my_order/order_bloc.dart';
import 'package:siplah_jpmall/src/models/user.dart';
import 'package:siplah_jpmall/src/ui/payment/payment_page.dart';
import 'package:siplah_jpmall/src/ui/sekolah/my_order_page.dart';

abstract class PaymentState {
  PaymentPageState createState();

  PaymentPageState get _state => createState();

  OrderBloc get _oBloc => _state.oBloc;
  AddressBloc get _aBloc => _state.aBloc;

  loadPayment(String id, String paymentId) {
    _oBloc.getPayment(id, paymentId);
  }

  Future<String> loadToken() => _oBloc.getToken();

  loadAddress(String userId) {
    _aBloc.getData(userId);
  }

  purchase(UserData userId, {List<Map<String, dynamic>> payment,
    List<Map<String, dynamic>> courier,
    List<Map<String, dynamic>> marketing,
    String transactionId,
    Map<String, dynamic> detail}) async {
    if(await _oBloc.purchase(
      transactionId: transactionId, payment: payment,marketing: marketing, detail: detail, courier: courier
    )) {
      Navigator.pop(_state.context);
      Navigator.push(_state.context, MaterialPageRoute(builder: (context) => MyOrderPage(user: userId)));
      print("berhasil");
    }else{
      print("Failed");
    }
  }

//  Future<CostModel> loadCost(Map<String, dynamic> data) async {
//    return Future.value(_rjBloc.getCost(data));
//  }
}