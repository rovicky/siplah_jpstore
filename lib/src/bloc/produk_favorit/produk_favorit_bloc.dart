import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/produk_model.dart';
import 'package:siplah_jpmall/src/resources/produk_favorit_provider.dart';

class ProdukFavBloc {
  ProductFavProvider _provider = new ProductFavProvider();
  PublishSubject<Products> _products = PublishSubject<Products>();
  Stream<Products> get products => _products.stream;

  getData(String id) async {
    Products data = await _provider.fetchProducts(id);
    _products.sink.add(data);
  }

  Future<bool> deleteData(String id, String idUser) async {
    final bool result = await _provider.deleteFromFavorite(id, idUser);
    if(result != null){
      return result;
    }else {
      return false;
    }
  }

  dispose() {
    _products.close();
  }
}