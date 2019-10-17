# flutter_mvp

#### 介绍
flutter的mvp简单封装！

#### 项目说明
1. 类似于Android的mvp简单封装
2. 网络简单封装，基础model为BaseEntity，data后面为数组[]，则返回调用onSuccessList方法返回数据，否则调用onSuccess方法返回数据（正式网络请求需打开dioutils文件里面_request方法下面的_dio.request和json.decode方法，注释掉JsonStr.shopList一行）
3. 拆分build方法，统一加入点击空白处类似iOS关闭键盘
