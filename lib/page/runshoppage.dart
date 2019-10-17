import 'package:flutter/material.dart';
import 'package:flutter_app/page/typepage.dart';
import '../basemvp/basestate.dart';
import '../entity/runshop_entity.dart';
import '../mvp/pesenter/runshopprerenter.dart';
import '../mvp/view/runshopview.dart';

class RunShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RunShopPageState();
  }
}

class _RunShopPageState extends BaseState<RunShopPage, RunShopPresenter> implements RunShopView {
  String TAG = 'RunShopPage';
  String json="";
  RunShopPresenter _present;
  RunshopEntity _runshopEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() {
    Map<String, dynamic> params = new Map();
    params['page'] = 1;
    params['tag'] = 1;
    _present.newsList(params);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text('RunShopPage'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Text('获取的数据：-->\n\n${_runshopEntity == null ? "" : _runshopEntity?.xList.map((item)=>item.title).toList()}'),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return TypePage();
                        }));
                      },
                      child: Text('进入第二页')),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Text('点击加载中'),
            onPressed: () {
              showProgress(msg: '加载中...');
            },
          ),
        ),
        onWillPop: ()=>_close(),
    );
  }

  @override
  void newsListError(int status, String message) {
    print('$TAG-->newsListError-->status=$status,message=$message');
  }

  @override
  void newsListSuccess(int status, String message, RunshopEntity data) {
    print('$TAG-->newsListSuccess-->status=$status,message=$message,\ndata=${data.toString()}');
    if (data == null) return;
    _runshopEntity = data;
    setState(() {});
  }

  @override
  RunShopPresenter createPresenter() {
    _present = RunShopPresenter();
    _present.attachView(this);
    return _present;
  }

  /**
   * 关闭加载框
   */
  _close() {
    print('$TAG-->关闭加载框');
//    dissProgress();
  }
}
