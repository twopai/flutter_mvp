import 'package:flutter_app/entity/runshop_entity.dart';
import 'package:flutter_app/mvp/view/runshopview.dart';

import '../../basemvp/basepresenter.dart';
import '../../net/apimanager.dart';
import 'runshoppresenterimp.dart';
import '../model/commmodel.dart';

class RunShopPresenter extends BasePresenter<RunShopView>implements RunShopPresenterImp{
  @override
  void newsList(Map<String, dynamic> params) {
    // TODO: implement newsList
    if(!isViewAttached())return;
    CommModel.requestPostData<RunshopEntity>(
      ApiManager.newsList,
      params: params,
      onSuccess: (int status, String message, RunshopEntity data) {
        mView.newsListSuccess(status, message, data);
      },onError: (int status, String message) {
        mView.newsListError(status, message);
      }
    );
  }
}