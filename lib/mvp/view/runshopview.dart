import 'package:flutter_app/entity/runshop_entity.dart';
import '../../basemvp/baseview.dart';

abstract class RunShopView extends BaseView{
  void newsListSuccess(int status, String message, RunshopEntity data);
  void newsListError(int status, String message);
}