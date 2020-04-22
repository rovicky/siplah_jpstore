import 'package:siplah_jpmall/src/bloc/raja_ongkir/raja_ongkir_bloc.dart';
import 'package:siplah_jpmall/src/ui/payment/pick_cost.dart';

abstract class PickCostState {
  PickCostPageState createState();
  PickCostPageState get _state => createState();

  RjBloc get _bloc => _state.bloc;

  load(Map<String, dynamic> data) async {
    _bloc.getCost(data);
  }


}