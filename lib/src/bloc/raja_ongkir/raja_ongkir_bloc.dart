import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/cost_model.dart';
import 'package:siplah_jpmall/src/resources/rajaongkir_provider.dart';

class RjBloc {
  final _provider = RajaOngkirProvider();
  PublishSubject<CostModel> _costModel = PublishSubject<CostModel>();

  Stream<CostModel> get costModel => _costModel.stream;

  Future<CostModel> getCost(Map<String, dynamic> data) async {
    CostModel event = await _provider.fetchCost(data);
    _costModel.sink.add(event);
    return event;
  }

  dispose(){
    _costModel.close();
  }
}