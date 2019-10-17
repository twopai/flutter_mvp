import 'package:flutter_app/basemvp/baseview.dart';
import 'package:flutter_app/entity/runshoptype_entity.dart';

abstract class TypeView extends BaseView{
  void shopListSuccess(int status, String message, RunshoptypeEntity data);
  void shopListError(int status, String message);
}