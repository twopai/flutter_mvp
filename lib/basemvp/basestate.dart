import 'package:flutter/material.dart';

import 'basepresenter.dart';

abstract class BaseState<T extends StatefulWidget, V extends BasePresenter>
    extends State<T> {
  V _basePresenter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化配置
    initConfig();
    //初始化Presenter，且Presenter也可以监听，故写在初始化监听之前
    _basePresenter = createPresenter();
    //初始化监听
    initLisener();
    //初始化数据
    initData();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: buildUi(context),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_basePresenter != null) {
      _basePresenter.detachView();
    }
    super.dispose();
  }

  V createPresenter();
  void initConfig(){}
  void initLisener(){}
  void initData(){}
  Widget buildUi(BuildContext context);

  /**
   * 显示加载进度框
   */
  showProgress({String msg}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return WillPopScope(
              child: AlertDialog(
                content: Row(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(msg == null ? '' : msg),
                    ),
                  ],
                ),
              ),
              onWillPop: (){
                print('BaseState-->关闭加载框');
                dissProgress();
              }
          );
        });
  }

  /**
   * 隐藏加载进度框
   */
  dissProgress() {
    Navigator.pop(context);
  }


}
