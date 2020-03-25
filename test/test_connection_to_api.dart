import 'package:flutter_test/flutter_test.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/resources/cart_provider.dart';
import 'package:siplah_jpmall/src/resources/home_provider.dart';
import 'package:siplah_jpmall/src/resources/produk_favorit_provider.dart';

void main(){
  ProductFavProvider p;
  p = ProductFavProvider();
  HomeProvider homeProvider = HomeProvider();
  CartProvider cartProvider = CartProvider();
  
  test("favorit_page", () async {
  final Products products = await p.fetchProducts("47");
    expect(products.error, false);
  });

  test("Home Page", () async {
    final ProductModeltwo productModeltwo = await homeProvider.fetchJson("47");
    expect(productModeltwo.data[0].produk[0].hargaZona[0]['nama'], "Zona 1");
  });
  
  test("Cart", () async {
    final CartModel cartModel = await cartProvider.fetchData("47");
    expect(cartModel.error, false);
  });
}