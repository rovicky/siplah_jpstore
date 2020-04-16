import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siplah_jpmall/src/models/cart_model.dart';
import 'package:siplah_jpmall/src/models/product_detail.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/models/result_user.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:siplah_jpmall/src/models/slide_model.dart';
import 'package:siplah_jpmall/src/resources/auth_provider.dart';
import 'package:siplah_jpmall/src/resources/cart_provider.dart';
import 'package:siplah_jpmall/src/resources/home_provider.dart';
import 'package:siplah_jpmall/src/resources/products_provider.dart';
import 'package:siplah_jpmall/src/resources/produk_favorit_provider.dart';
import 'package:siplah_jpmall/src/resources/setting_provider.dart';

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
    final ProductModeltwo productModeltwo = await homeProvider.fetchJson("60");
    expect(productModeltwo.error, false);
  });
  test("Slider", () async {
    final SlideModel productModeltwo = await homeProvider.fetchSlide();
    expect(productModeltwo.error, false);
  });
  
  test("Cart", () async {
    final CartModel cartModel = await cartProvider.fetchData("47");
    expect(cartModel.error, false);
  });

  test("Delete Cart", () async {
    expect(await cartProvider.delete("11", "47"), true);
  });

  test("product detail", () async {
    ProductDetail result = await ProductProvider().fetchProduct("13974", "");
//    debugPrint(result.toString());
    expect(result.id, "13974");
  });

  test("delete favorite", () async {
    bool result = await ProductFavProvider().deleteFromFavorite("13", "47");
//    debugPrint(result.toString());
    expect(result, true);
  });

  test("Login Test", () async {
    ResultUser result = await AuthProvider().fetchLogin("anggarasaja98@gmail.com", "12345");
//    debugPrint(result.toString());
    expect(result.error, false);
  });

  test("get credential Test", () async {
    String result = await AuthProvider().getCredential();
//    debugPrint(result.toString());
    expect(result, "47");
  });

  test("fetch setting Test", () async {
    ResultSetting result = await SettingProvider().fetchData();
//    debugPrint(result.toString());
    expect(result.error, false);
  });
}