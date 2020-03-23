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

  dispose() {
    _products.close();
  }
}