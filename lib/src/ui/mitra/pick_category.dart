import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/mitra/mitra_bloc.dart';
import 'package:siplah_jpmall/src/models/category_model.dart';
import 'package:siplah_jpmall/src/utils/mytools.dart';

class PickCategory extends StatefulWidget {
  @override
  _PickCategoryState createState() => _PickCategoryState();
}

class _PickCategoryState extends State<PickCategory> {
  final bloc = MitraBloc();

  @override
  void initState() {
    super.initState();
    bloc.loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pilih Category",
          style: MyTools.boldStyle(size: 18, color: MyTools.darkAccentColor),
        ),
      ),
      body: StreamBuilder<CategoryModel>(
        stream: bloc.categoryList,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data.data.length == 0) {
              return MyTools.errorWidget(context, message: "Tidak Ada Data");
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right : 10, top: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(snapshot.data.data.length, (index) => _widgetListTile(context, key: snapshot.data.data[index].nama, onPressed: (){
                    Navigator.pop(context, {
                      "title":snapshot.data.data[index].nama,
                      "id":snapshot.data.data[index].id
                    });
                  })),
                ),
              ),
            );
          } else if(snapshot.hasError) {
            return MyTools.errorWidget(context, message: "Snapshot error!");
          } return Center(child: MyTools.loadingWidget,);
        }
      ),
    );
  }

  _widgetListTile(context, {String key, Function onPressed}) {
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
            onTap: onPressed ?? () {},
            title: Text(key ?? "Tidak Ada Judul",
                style: MyTools.boldStyle(
                    size: 14, color: MyTools.darkAccentColor)),
          ),
        ),
      ),
    );
  }
}
