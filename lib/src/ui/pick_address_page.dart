import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/address/address_bloc.dart';
import 'package:siplah_jpmall/src/bloc/address/pick_address_state.dart';
import 'package:siplah_jpmall/src/models/address/district_model.dart';
import 'package:siplah_jpmall/src/models/address/province_model.dart';
import 'package:siplah_jpmall/src/models/address/sub_district_model.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PickAddressPage extends StatefulWidget {
  final int method;
  final String provinceId;
  final String districtId;

  const PickAddressPage({Key key, this.provinceId, this.districtId, this.method}) : super(key: key);
  @override
  State<StatefulWidget> createState() => PickAddressPageState();

}

class PickAddressPageState extends State<PickAddressPage> with PickAddressState {
  final bloc = AddressBloc();

  @override
  void initState() {
    super.initState();
    if(this.widget.method == 0){
      loadDistrict(this.widget.provinceId);
    }else if(this.widget.method == 1){
      loadSubDistrict(this.widget.provinceId, this.widget.districtId);
    }else{
      loadProvince();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: this.widget.method == 0 ? _district(context) : this.widget.method == 1 ? _subDistrict(context) : _province(context),
    );
  }

  _province(context) {
    return StreamBuilder<ProvinceModel>(
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return MyTools.errorWidget(context, message: snapshot.error.toString());
          }else if(snapshot.hasData) {
            if(snapshot.data.error) {
              return MyTools.errorWidget(context, message: snapshot.data.pesanUsr);
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(snapshot.data.data.length, (index) => Padding(padding: const EdgeInsets.only(top: 5, bottom: 4, right: 10, left: 10), child: _customTile(context,id: snapshot.data.data[index].id, title: snapshot.data.data[index].nama),)),
              ),
            );
          }return Center(child: CircularProgressIndicator());
        }, stream: bloc.province,);
  }

  _district(context) {
    return StreamBuilder<DistrictModel>(
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return MyTools.errorWidget(context, message: snapshot.error.toString());
        }else if(snapshot.hasData) {
          if(snapshot.data.error) {
            return MyTools.errorWidget(context, message: snapshot.data.pesanUsr);
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(snapshot.data.data.length, (index) => Padding(padding: const EdgeInsets.only(top: 5, bottom: 4, right: 10, left: 10), child: _customTile(context,id: snapshot.data.data[index].id, title: snapshot.data.data[index].nama),)),
            ),
          );
        }return Center(child: CircularProgressIndicator());
      }, stream: bloc.district,);
  }

  _subDistrict(context) {
    return StreamBuilder<SubDistrictModel>(
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return MyTools.errorWidget(context, message: snapshot.error.toString());
        }else if(snapshot.hasData) {
          if(snapshot.data.error) {
            return MyTools.errorWidget(context, message: snapshot.data.pesanUsr);
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(snapshot.data.data.length, (index) => Padding(padding: const EdgeInsets.only(top: 5, bottom: 4, right: 10, left: 10), child: _customTile(context,id: snapshot.data.data[index].id, title: snapshot.data.data[index].nama),)),
            ),
          );
        }return Center(child: CircularProgressIndicator());
      }, stream: bloc.subDistrict,);
  }

  _customTile(context, {String title, String id}) {
    return Container(
        height: 70,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color:
                Colors.black54.withOpacity(0.8).withAlpha(25),
                blurRadius: 7,
                offset: Offset(0, 0),
                spreadRadius: 0.4)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: ()=> Navigator.pop(context, {
            "title":title,
            "id":id
          }),
          title: Text(title, style: MyTools.boldStyle(size: 16, color: MyTools.darkAccentColor),),
          subtitle: Text("Tap pilihan anda untuk kembali", style: MyTools.regular(size: 12, color: MyTools.darkAccentColor),),
        ));
  }

  @override
  PickAddressPageState createState() => this;
}