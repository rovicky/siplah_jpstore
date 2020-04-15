import 'package:rxdart/rxdart.dart';
import 'package:siplah_jpmall/src/models/setting_detail_model.dart';
import 'package:siplah_jpmall/src/models/setting_model.dart';
import 'package:siplah_jpmall/src/resources/setting_provider.dart';

class SettingBloc {
  final _provider = SettingProvider();
  PublishSubject<ResultSetting> _setting = PublishSubject<ResultSetting>();
  PublishSubject<SettingDetail> _settingDetail = PublishSubject<SettingDetail>();

  Stream<ResultSetting> get setting => _setting.stream;
  Stream<SettingDetail> get settingDetail => _settingDetail.stream;

  getData() async {
    ResultSetting result = await _provider.fetchData();
    _setting.sink.add(result);
  }

  getDetail(String id) async {
    SettingDetail result = await _provider.fetchBlog(id);
    _settingDetail.sink.add(result);
  }

  dispose() {
  _setting.close();
  _settingDetail.close();
  }
}