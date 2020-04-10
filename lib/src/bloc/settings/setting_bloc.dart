import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:siplah_jpmall/src/resources/setting_provider.dart';

class SettingBloc {
  final _provider = SettingProvider();
  PublishSubject<ResultSetting> _setting = PublishSubject<ResultSetting>();

  Stream<ResultSetting> get setting => _setting.stream;

  getData() async {
    ResultSetting result = await _provider.fetchData();
    _setting.sink.add(result);
  }

  dispose() {
  _setting.close();
  }

}