import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/resources/produk_favorit_provider.dart';

class ProdukFavBloc {
  ProductFavProvider _provider = new ProductFavProvider();
  PublishSubject<Products> _products = PublishSubject<Products>();
  StreamController<bool> _isFaved = StreamController<bool>();
  Stream<Products> get products => _products.stream;
  Stream<bool> get isFaved => _isFaved.stream;

  getData(String id) async {
    Products data = await _provider.fetchProducts(id);
    _products.sink.add(data);
  }

  Future<bool> deleteData(String id, String idUser) async {
    final bool result = await _provider.deleteFromFavorite(id, idUser);
    if (result != null) {
      isFavorited(id, idUser);
      return result;
    } else {
      return false;
    }
  }

  Future<bool> isFavorited(String id, String userId) async {
    Products data = await _provider.fetchProducts(userId, idProduct: id);
    if (data.data.length != 0) {
      _isFaved.sink.add(true);
      return true;
    }
    _isFaved.sink.add(false);
    return false;
  }

  Future<bool> favorited(String id, String idUser) =>
      _provider.addToFavorite(id, idUser);

  dispose() {
    _products.close();
    _isFaved.close();
  }
}
