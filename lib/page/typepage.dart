import 'package:flutter/material.dart';
import 'package:flutter_app/basemvp/basestate.dart';
import 'package:flutter_app/mvp/pesenter/typepresenter.dart';
import 'package:flutter_app/mvp/view/typeview.dart';

import '../entity/runshoptype_entity.dart';

class TypePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TypePageState();
  }
}
class _TypePageState extends BaseState<TypePage, TypePresenter> implements TypeView {
  String TAG = 'TypePage';
  TypePresenter _presenter;
  RunshoptypeEntity _typeEntity;

  @override
  TypePresenter createPresenter() {
    _presenter = TypePresenter();
    _presenter.attachView(this);
    return _presenter;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() {
    Map<String, dynamic> params = new Map();
    _presenter.shopList(params);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('$TAG'),
      ),
      body: Center(
        child: Text("获取的数据：\n${_typeEntity == null ? "" : _typeEntity?.xList.map((item)=>item.name).toList()}"),
      ),
    );
  }

  @override
  void shopListError(int status, String message) {
    print('$TAG-->newsListError-->status=$status,message=$message');
  }

  @override
  void shopListSuccess(int status, String message, RunshoptypeEntity data) {
    print('$TAG-->newsListSuccess-->status=$status,message=$message,\ndata=${data.toString()}');
    if (data == null) return;
    _typeEntity = data;
    setState(() {});
  }
}
