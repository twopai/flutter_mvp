import 'package:dio/dio.dart';

import '../../net/dioutils.dart';

class CommModel {
  /**
   * post请求
   */
  static requestPostData<T>(String url,
      {Function(int status, String message, T t3) onSuccess,
      Function(int status, String message, List<T> list) onSuccessList,
      Function onError,
      Map<String, dynamic> params,
      CancelToken cancelToken,
      Options options}) {

    DioUtils.instance.post<T>(url, params: params, onSuccess: (int status, String message, T data) {
      if(onSuccess!=null)onSuccess(status, message, data);
    },onSuccessList: (int status, String message,  List<T> data) {
      if(onSuccessList!=null)onSuccessList(status, message, data);
    },onError: (int status, String message) {
      onError(status, message);
    });
  }
  /**
   * get请求
   */
  static requestGetData<T>(String url,
      {Function(int status, String message, T t3) onSuccess,
      Function(int status, String message, List<T> list) onSuccessList,
      Function onError,
      Map<String, dynamic> params,
      CancelToken cancelToken,
      Options options}) {
    DioUtils.instance.post<T>(url, params: params, onSuccess: (int status, String message, T data) {
      if(onSuccess!=null)onSuccess(status, message, data);
    },onSuccessList: (int status, String message,  List<T> data) {
      if(onSuccessList!=null)onSuccessList(status, message, data);
     },
     onError: (int status, String message) {
      onError(status, message);
    });
  }
}
