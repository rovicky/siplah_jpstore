import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/raja_ongkir/pick_cost_state.dart';
import 'package:siplah_jpmall/src/bloc/raja_ongkir/raja_ongkir_bloc.dart';
import 'package:siplah_jpmall/src/models/cost_model.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PickCost extends StatefulWidget {
  final Map<String, dynamic> data;

  const PickCost({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PickCostPageState();
}

class PickCostPageState extends State<PickCost> with PickCostState {
  final bloc = RjBloc();

  @override
  void initState() {
    super.initState();
    if (this.widget.data != null) {
      load(this.widget.data);
    }
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          "Pilih Kurir",
          style: MyTools.boldStyle(color: MyTools.darkAccentColor, size: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<CostModel>(
          stream: bloc.costModel,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return MyTools.errorWidget(context,
                  message: snapshot.error.toString());
            } else if (snapshot.hasData) {
              if (snapshot.data.rajaongkir.status.code != 200) {
                return MyTools.errorWidget(context,
                    message: snapshot.data.rajaongkir.status.description);
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      snapshot.data.rajaongkir.results.length,
                      (index) => ListTile(
                            title: Text(
                              snapshot.data.rajaongkir.results[index].name,
                              style: MyTools.boldStyle(
                                  color: MyTools.darkAccentColor, size: 14),
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                  snapshot.data.rajaongkir.results[index].costs
                                      .length,
                                  (i) => _customListTile({
                                        "onPressed": () {
                                          Navigator.pop(context, {
                                            "service": snapshot
                                                .data
                                                .rajaongkir
                                                .results[index]
                                                .costs[i]
                                                .service,
                                            "courier_name": snapshot.data
                                                .rajaongkir.results[index].name,
                                            "courier_code": snapshot.data
                                                .rajaongkir.results[index].code,
                                            "cost": snapshot
                                                .data
                                                .rajaongkir
                                                .results[index]
                                                .costs[i]
                                                .cost[0]
                                                .value,
                                            "etd": snapshot
                                                .data
                                                .rajaongkir
                                                .results[index]
                                                .costs[i]
                                                .cost[0]
                                                .etd,
                                          });
                                        },
                                        "title": snapshot.data.rajaongkir
                                            .results[index].costs[i].service,
                                        "subtitle": snapshot
                                                .data
                                                .rajaongkir
                                                .results[index]
                                                .costs[i]
                                                .cost[0]
                                                .etd
                                                .toLowerCase()
                                                .contains("hari")
                                            ? "Rp " +
                                                MyTools.priceFormat(snapshot
                                                    .data
                                                    .rajaongkir
                                                    .results[index]
                                                    .costs[i]
                                                    .cost[0]
                                                    .value) +
                                                " | " +
                                                snapshot.data.rajaongkir.results[index].costs[i].cost[0].etd
                                                    .toLowerCase()
                                            : (snapshot.data.rajaongkir.results[index].costs[i].cost[0].etd == "")
                                                ? "Rp " +
                                                    MyTools.priceFormat(snapshot
                                                        .data
                                                        .rajaongkir
                                                        .results[index]
                                                        .costs[i]
                                                        .cost[0]
                                                        .value)
                                                : "Rp " +
                                                    MyTools.priceFormat(snapshot
                                                        .data
                                                        .rajaongkir
                                                        .results[index]
                                                        .costs[i]
                                                        .cost[0]
                                                        .value) +
                                                    " | " +
                                                    snapshot
                                                        .data
                                                        .rajaongkir
                                                        .results[index]
                                                        .costs[i]
                                                        .cost[0]
                                                        .etd +
                                                    " hari"
                                      })),
                            ),
                          )),
                ),
              );
            }
            return Center(
              child: MyTools.loadingWidget,
            );
          }),
    );
  }

  _customListTile(Map<String, dynamic> child) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 7),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: ListTile(
            onTap: () {
              child['onPressed']();
            },
            title: Text(
              child['title'],
              style:
                  MyTools.boldStyle(color: MyTools.darkAccentColor, size: 14),
            ),
            subtitle: child['subtitle'] == null
                ? null
                : Text(
                    child['subtitle'] ?? '',
                    style: MyTools.regular(
                        size: 12, color: MyTools.darkAccentColor),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  PickCostPageState createState() => this;
}
