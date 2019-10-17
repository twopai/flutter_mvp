import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/typepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  RunShopPresenter createPresenter() {
    _present = RunShopPresenter();
    _present.attachView(this);
    return _present;
  }

  @override
  void initConfig() {
    // TODO: implement initConfig

//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
  }

  @override
  void initData() {
    // TODO: implement initData

  }

  @override
  void initLisener() {
    // TODO: implement initLisener
  }
  void _getData() {
    Map<String, dynamic> params = new Map();
    params['page'] = 1;
    params['tag'] = 1;
    _present.newsList(params);
  }
  @override
  Widget buildUi(BuildContext context) {

    ///Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    var physicalSize = window.physicalSize;
    print('Device physicalSizewidth 0-->px:${physicalSize.width}'); //Device width
    print('Device physicalSizeheight 0-->px:${physicalSize.height}'); //Device height
    var size2 = MediaQuery.of(context).size;
    print('Device width 0-->dp:${size2.width}'); //Device width
    print('Device height 0-->dp:${size2.height}'); //Device height
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: size2.width, height: size2.height)..init(context);

    print('Device width px:${ScreenUtil.screenWidth}'); //Device width
    print('Device height px:${ScreenUtil.screenHeight}'); //Device height
    print(
        'Device pixel density:${ScreenUtil.pixelRatio}'); //Device pixel density
    print(
        'Bottom safe zone distance dp:${ScreenUtil.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        'Status bar height px:${ScreenUtil.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit px

    return Scaffold(
      appBar: AppBar(
        title: Text('RunShopPage'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              height: ScreenUtil().setHeight(20),
              color: Colors.blue,
            ),
            Text('获取的数据：-->\n\n${_runshopEntity == null ? "" : _runshopEntity?.xList.map((item)=>item.title).toList()}'),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return TypePage();
                    }));
                  },
                  child: Text('进入第二页',
                    style: TextStyle(fontSize: ScreenUtil(allowFontScaling: false).setSp(14)),
                  )
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('点击加载中'),
        onPressed: () {
          _getData();
          showProgress(msg: '加载中...');
        },
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return ;
//  }
  @override
  void newsListError(int status, String message) {
    print('$TAG-->newsListError-->status=$status,message=$message');
//    dissProgress();
  }

  @override
  void newsListSuccess(int status, String message, RunshopEntity data) {
//    dissProgress();
    print('$TAG-->newsListSuccess-->status=$status,message=$message,\ndata=${data.toString()}');
    if (data == null) return;
    _runshopEntity = data;
//    setState(() {});
  }
}
