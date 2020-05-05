import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/category_model.dart';
import 'package:siplah_jpmall/src/models/marketing_model.dart';
import 'package:siplah_jpmall/src/models/mitra/cabang_model.dart';
import 'package:siplah_jpmall/src/models/mitra/order_in_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra/product_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra/products_mitra_model.dart';
import 'package:siplah_jpmall/src/models/mitra_detail_model.dart';
import 'package:siplah_jpmall/src/models/mitra_list_model.dart';
import 'package:siplah_jpmall/src/resources/mitra_provider.dart';

class MitraBloc {
  final _provider = MitraDetailProvider();
  final _mitraProfile = PublishSubject<MitraDetailModel>();
  final _mitraList = PublishSubject<MitraListModel>();
  final _marketing = PublishSubject<MarketingModel>();
  final _item = PublishSubject<List<String>>();
  final _cabang = PublishSubject<CabangModel>();
  final _mitraOrderList = PublishSubject<OrderInMitra>();
  final _categoryList = PublishSubject<CategoryModel>();

  Stream<MitraDetailModel> get mitraProfile => _mitraProfile.stream;
  Stream<MitraListModel> get mitraList => _mitraList.stream;
  Stream<MarketingModel> get marketing => _marketing.stream;
  Stream<List<String>> get item => _item.stream;
  Stream<CabangModel> get cabang => _cabang.stream;
  Stream<OrderInMitra> get orderList => _mitraOrderList.stream;
  Stream<CategoryModel> get categoryList => _categoryList.stream;

  Future<Map<String, dynamic>> deleteMarketing(String mitraId, String id) => _provider.deleteMarketing(mitraId, id);
  
  Future<ProductsMitra> getProductsOfMitra(String mitraId, {int length, int start}) => _provider.fetchProductsInMitra(mitraId, length: length, start: start);

  loadCategory() async {
    CategoryModel event = await _provider.fetchCategory();
    _categoryList.sink.add(event);
  }

  Future<OrderInMitra> loadMitraOrderList(String mitraId, {int limit, int page}) async {
    OrderInMitra event = await _provider.fetchMitraOrder(mitraId, limit: limit, page: page);
    _mitraOrderList.sink.add(event);
    return event;
  }

  Future<CabangModel>cabangLoad(String mitraId, {int limit, int start}) async {
    CabangModel event = await _provider.fetchCabangMitra(mitraId, length: limit, start: start);
    print(event);
    _cabang.sink.add(event);
    return event;
  }

  void getMitra(String mitraId) async {
    MitraDetailModel mitra = await _provider.getMitra(mitraId);
    _mitraProfile.sink.add(mitra);
  }

  void getItem(String id) async {
    final productResult =
        await _provider.fetchProductsInMitra(id, length: 1, start: 0);
    final orderResult = await _provider.fetchMitraOrder(id, limit: 1, page: 1);
    if (orderResult != null && productResult != null) {
      var list = [
        orderResult.paging.jmlData ?? orderResult.data.length.toString(),
        productResult.recordsTotal.toString(),
        "0",
        "0"
      ];
      _item.sink.add(list);
    }
  }

  Future<Map<String, dynamic>> createProduct(ProductMitraModel model) async {
    return await _provider.createProductMitra(model);
  }

  Future<Map<String, dynamic>> createCabangMitra(Cabang model, {int mode}) async {
    return await _provider.createCabangMitra(model);
  }

  Future<Map<String, dynamic>> deleteCabang(String id) async {
    return await _provider.deleteCabangMitra(id);
  }

  void getListMitra() async {
    MitraListModel event = await _provider.getMitras();
    _mitraList.sink.add(event);
  }

  void getMarketing(String mitraId) async {
    MarketingModel event = await _provider.fetchMarketing(mitraId);
    _marketing.sink.add(event);
  }

  void dispose() {
    _mitraProfile.close();
    _mitraList.close();
    _marketing.close();
    _item.close();
    _cabang.close();
    _mitraOrderList.close();
    _categoryList.close();
  }
}
