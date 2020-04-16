import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/product_model_two.dart';
import 'package:siplah_jpmall/src/models/recomened_products_model.dart';
import 'package:siplah_jpmall/src/models/slide_model.dart';
import 'package:siplah_jpmall/src/resources/home_provider.dart';

class HomeBloc {

  HomeProvider _homeProvider = HomeProvider();
  final PublishSubject<ProductModeltwo> _homeContent = PublishSubject<ProductModeltwo>();
  final _slide = PublishSubject<SlideModel>();

  Stream<ProductModeltwo> get homeContent => _homeContent.stream;
  Stream<SlideModel> get slide => _slide.stream;

  Future getData(String id) async {
    ProductModeltwo productModeltwo = await _homeProvider.fetchJson(id);
    _homeContent.sink.add(productModeltwo);
  }

  Future<RecomendedProducts> getRP(String userId, {int page}) async {
    return _homeProvider.fetchrp(userId, page: page);
  }

  getSlide() async {
    SlideModel event = await _homeProvider.fetchSlide();
    _slide.sink.add(event);
  }

  dispose(){
    _homeContent.close();
    _slide.close();
  }
}