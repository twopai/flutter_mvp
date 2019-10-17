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
  void initData() {
    // TODO: implement initData
    _getData();
  }

  void _getData() {
    Map<String, dynamic> params = new Map();
    _presenter.shopList(params);
  }
  @override
  Widget buildUi(BuildContext context) {
    // TODO: implement buildUi
    return Scaffold(
      appBar: AppBar(
        title: Text('$TAG'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              child: Text('点击空白处类似iOS关闭键盘'),
            ),
            //输入框
            TextField(),
            //数据
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("获取的数据：\n${_typeEntity == null ? "" : _typeEntity?.xList.map((item)=>item.name).toList()}"),
            )
          ],
        ),
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
