import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/ui/page_feeds.dart';

abstract class FeedState {
  FeedsPageState createState();
  FeedsPageState get _state => createState();

  MitraBloc get _bloc => _state.bloc;

  load() {
    _bloc.getListMitra();
  }


}