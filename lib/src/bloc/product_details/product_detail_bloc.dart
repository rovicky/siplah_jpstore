import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/product_detail.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/resources/products_provider.dart';
import 'package:siplah_jpmall/src/resources/produk_favorit_provider.dart';

class ProductDetailBloc{
  final _provider = ProductProvider();
  PublishSubject<ProductDetail> _product = PublishSubject<ProductDetail>();
  PublishSubject<ProductModeltwo> _products = PublishSubject<ProductModeltwo>();
  StreamController<bool> _favorite = StreamController<bool>();

  Stream<ProductModeltwo> get products => _products.stream;
  Stream<ProductDetail> get product => _product.stream;
  Stream<bool> get favorite => _favorite.stream;

  getData(String id, String userId, {String mitraId, String categoryId}) async {
    ProductDetail result = await _provider.fetchProduct(id, userId);
    _product.sink.add(result);
  }

  getMoreProducts(String userId, {String mitraId, String categoryId}) async {
    ProductModeltwo products = await _provider.fetchProducts(id: userId, categoryId: categoryId, mitraId: mitraId);
    _products.sink.add(products);
  }

  Future<Map<String, dynamic>> getProductFavorite(String id, productId) async {
    Products produk = await ProductFavProvider().fetchProducts(id, idProduct: productId);
    if(produk.data.length == 0) {
      return {
        "status":false
      };
    }else {
      return {
        "status":true,
        "id":produk.data[0].id
      };
    }
  }




  Future<bool> addToFavorite(String id, String productId) async {
//    bool result =
    return await ProductFavProvider().addToFavorite(productId, id);
  }

  Future<bool> deleteFromFavorite(String id, String productId) async {
    return await ProductFavProvider().deleteFromFavorite(productId, id);
  }

  dispose() {
    _product.close();
    _products.close();
    _favorite.close();
  }
}