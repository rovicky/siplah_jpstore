import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/search_model.dart';
import 'package:siplah_jpmall/src/resources/products_provider.dart';


class ProductBloc{
  final _provider = ProductProvider();
  final _productFetcher = PublishSubject<SearchModel>();

  Stream<SearchModel> get searchProducts => _productFetcher.stream;

  Future<SearchModel> searchData(String key, {String userId, int page}) async {
    SearchModel event = await _provider.searchProduct(key, userId, page: page);
    _productFetcher.sink.add(event);
    return event;
  }

  dispose() async {
    _productFetcher.close();
  }
}