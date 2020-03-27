import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/resources/cart_provider.dart';

class CartBloc {
  CartProvider _cartProvider = CartProvider();
  final PublishSubject<CartModel> _cartModel = PublishSubject<CartModel>();

  Stream<CartModel> get cart => _cartModel.stream;

  getData(String id) async {
    CartModel event = await _cartProvider.fetchData(id);
    _cartModel.sink.add(event);
  }

  dispose(){
    _cartModel.close();
  }

  Future<bool> delete(String id, String userId) async {
    final bool result = await _cartProvider.delete(id, userId);
    return result;
  }
}