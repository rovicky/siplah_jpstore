import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/resources/cart_provider.dart';
import 'package:siplah_jpmall/src/resources/order_provider.dart';

class CartBloc {
  CartProvider _cartProvider = CartProvider();
  OrderProvider _orderProvider = OrderProvider();
  final PublishSubject<CartModel> _cartModel = PublishSubject<CartModel>();

  Stream<CartModel> get cart => _cartModel.stream;

  getData(String id) async {
    CartModel event = await _cartProvider.fetchData(id);
    _cartModel.sink.add(event);
  }

  dispose() {
    _cartModel.close();
  }

  Future<bool> delete(String id, String userId) async {
    final bool result = await _cartProvider.delete(id, userId);
    return result;
  }

  Future<bool> create(String id, String userId, String mitraId,
      {int qty = 1}) async {
    final bool result =
        await _cartProvider.postCart(userId, mitraId, id, jumlah: qty);
    return result;
  }

  Future<bool> update(String id, {int qty = 1}) async {
    final bool result = await _cartProvider.setQty(id, jumlah: qty);
    return result;
  }

  Future<Map<String, dynamic>> createPayment(String idUser, List<String> ids,) => _orderProvider.createPayment(idUser, ids);
}
