import 'package:siplah_jpmall/src/bloc/settings/setting_bloc.dart';
import 'package:siplah_jpmall/src/ui/settings/setting_detail.dart';

abstract class SettingDetailState {
  SettingDetailPageState createState();

  SettingDetailPageState get _state => createState();

  SettingBloc get _bloc => _state.bloc;

  load(String id) {
    _bloc.getDetail(id);
  }
}