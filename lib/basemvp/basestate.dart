import 'package:flutter/material.dart';

import 'basepresenter.dart';

abstract class BaseState<T extends StatefulWidget, V extends BasePresenter>
    extends State<T> {
  V _basePresenter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _basePresenter = createPresenter();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
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
