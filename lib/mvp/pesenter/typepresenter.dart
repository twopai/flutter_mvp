import 'package:flutter_app/basemvp/basepresenter.dart';
import 'package:flutter_app/entity/runshoptype_entity.dart';
import 'package:flutter_app/mvp/pesenter/typepresenterimp.dart';
import 'package:flutter_app/mvp/view/typeview.dart';
import 'package:flutter_app/net/apimanager.dart';
import 'package:flutter_app/mvp/model/commmodel.dart';

class TypePresenter extends BasePresenter<TypeView>implements TypePresenterImp{
  @override
  void shopList(Map<String,dynamic > params) {
    CommModel.requestPostData<RunshoptypeEntity>(
        ApiManager.shopList,
        params: params,
        onSuccess: (int status, String message, RunshoptypeEntity data) {
          if(!isViewAttached())return;
          mView.shopListSuccess(status, message, data);
        },onError: (int status, String message) {
          if(!isViewAttached())return;
          mView.shopListError(status, message);
      }
    );
  }
}