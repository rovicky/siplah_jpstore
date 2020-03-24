import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/resources/home_provider.dart';

class HomeBloc {

  HomeProvider _homeProvider = HomeProvider();
  final PublishSubject<ProductModeltwo> _homeContent = PublishSubject<ProductModeltwo>();

  Stream<ProductModeltwo> get homeContent => _homeContent.stream;

  Future getData(String id) async {
    ProductModeltwo productModeltwo = await _homeProvider.fetchJson(id);
    _homeContent.sink.add(productModeltwo);
  }

  dispose(){
    _homeContent.close();
  }
}