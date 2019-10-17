
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/util/jsonstr.dart';
import 'package:rxdart/rxdart.dart';

import '../entity_factory.dart';
import 'baseentity.dart';
import '../util/constant.dart';
import 'errorhandle.dart';
import 'intercept.dart';

class DioUtils {

  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio(){
    return _dio;
  }

  DioUtils._internal(){
    var options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 30000,
      responseType: ResponseType.plain,
      validateStatus: (status){
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: Constant.BASE_URL,
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    _dio = Dio(options);
    /// 统一添加身份验证请求头
    _dio.interceptors.add(AuthInterceptor());
    /// 刷新Token
    _dio.interceptors.add(TokenInterceptor());
    /// 打印Log
    _dio.interceptors.add(LoggingInterceptor());
    /// 适配数据
    _dio.interceptors.add(AdapterInterceptor());
  }

  // 数据返回格式统一，统一处理异常
  Future<BaseEntity<T>> _request<T>(String method, String url, {Map<String, dynamic> data, CancelToken cancelToken, Options options}) async {
//    print('request-->params=${data.toString()}');
//    var response = await _dio.request(url, data: data, options: _checkOptions(method, options), cancelToken: cancelToken);
    int _code;
    String _msg;
    T _data;

    try {
//      Map<String, dynamic> _map = json.decode(response.data.toString());
      Map<String, dynamic> _map = data['tag']==1?JsonStr.newsList:JsonStr.shopList;
      _code = _map["status"];
      _msg = _map["message"];
      if (_map.containsKey("data")){
        _data = EntityFactory.generateOBJ(_map["data"]);
      }
    }catch(e){
      print(e);
      return parseError();
    }
    return BaseEntity(_code, _msg, _data);
  }

  Future<BaseEntity<List<T>>> _requestList<T>(String method, String url, {Map<String, dynamic> data, CancelToken cancelToken, Options options}) async {
    var response = await _dio.request(url, data: data, options: _checkOptions(method, options), cancelToken: cancelToken);
    int _code;
    String _msg;
    List<T> _data = [];

    try {
      Map<String, dynamic> _map = json.decode(response.data.toString());
      _code = _map["status"];
      _msg = _map["message"];
      if (_map.containsKey("data")){
        ///  List类型处理，暂不考虑Map
        (_map["data"] as List).forEach((item){
          _data.add(EntityFactory.generateOBJ<T>(item));
        });
        BaseEntity(_code, _msg, _data);
      }
    }catch(e){
      print(e);
      return parseError();
    }
    return BaseEntity(_code, _msg, _data);
  }

  BaseEntity parseError(){
    return BaseEntity(ExceptionHandle.parse_error, "数据解析错误", null);
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future<BaseEntity<T>> request<T>(String method, String url, {Map<String, dynamic> params, CancelToken cancelToken, Options options}) async {

    var response = await _request<T>(method, url, data: params, options: options, cancelToken: cancelToken);
    return response;
  }

  Future<BaseEntity<List<T>>> requestList<T>(String method, String url, {Map<String, dynamic> params, CancelToken cancelToken, Options options}) async {
    var response = await _requestList<T>(method, url, data: params, options: options, cancelToken: cancelToken);
    return response;
  }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回List<T>)
  requestNetwork<T>(String method, String url, {Function(int status,String message,T t3) onSuccess, Function(int status,String message,List<T> list) onSuccessList, Function onError,
    Map<String, dynamic> params, CancelToken cancelToken, Options options}){

    Observable.fromFuture(onSuccess != null ? request<T>(method, url, params: params, options: options, cancelToken: cancelToken) :
    requestList<T>(method, url, params: params, options: options, cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result){
      print("listen： status: ${result.status}, message: ${result.message}");
      if (result.status == 1){
        onSuccess != null ? onSuccess(result.status,result.message,result.data) : onSuccessList(result.status,result.message,result.data);
      }else{
        onError == null ? _onError(result.status, result.message) : onError(result.status, result.message);
      }
    }, onError: (e){
      Error error = ExceptionHandle.handleException(e);
      onError == null ? _onError(error.status, error.message) : onError(error.status, error.message);
//          print("DioUtils-->onError-->error.status=${error.status}, error.message=${error.message}");
//      if (CancelToken.isCancel(e)){
//        print("取消请求接口： $url");
//      }else{
//        onError == null ? _onError(error.status, error.message) : onError(error.status, error.message);
//      }
    });
  }

  _onError(int status, String message){
    print("接口请求异常： code: $status, mag: $message");
//    Toast.show(message:message);
  }

  post<T>(String url, {Function(int status,String message,T t3) onSuccess, Function(int status,String message,List<T> list) onSuccessList, Function onError, Map<String, dynamic> params, CancelToken cancelToken, Options options}){
    requestNetwork<T>("POST", url, onSuccess: onSuccess, onSuccessList: onSuccessList, onError: onError, params: params, options: options, cancelToken: cancelToken);
  }

  get<T>(String url, {Function(int status,String message,T t3) onSuccess, Function(int status,String message,List<T> list) onSuccessList, Function onError, Map<String, dynamic> params, CancelToken cancelToken, Options options}){
    requestNetwork<T>("GET", url, onSuccess: onSuccess, onSuccessList: onSuccessList, onError: onError, params: params, options: options, cancelToken: cancelToken);
  }

  put<T>(String url, {Function(int status,String message,T t3) onSuccess, Function(int status,String message,List<T> list) onSuccessList, Function onError, Map<String, dynamic> params, CancelToken cancelToken, Options options}){
    requestNetwork<T>("PUT", url, onSuccess: onSuccess, onSuccessList: onSuccessList, onError: onError, params: params, options: options, cancelToken: cancelToken);
  }

  delete<T>(String url, {Function(int status,String message,T t3) onSuccess, Function(int status,String message,List<T> list) onSuccessList, Function onError, Map<String, dynamic> params, CancelToken cancelToken, Options options}){
    requestNetwork<T>("DELETE", url, onSuccess: onSuccess, onSuccessList: onSuccessList, onError: onError, params: params, options: options, cancelToken: cancelToken);
  }

  /***********************************************/
  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath,{Function(int count, int total) onProgress,Function() onSuccess,Function(Exception e) onFail,Map<String, dynamic> params,}) async {
    Response response;
    var options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.plain,
      validateStatus: (status){
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
//      baseUrl: Constant.BASE_URL,
//      contentType: ContentType('application', 'x-www-form-urlencoded', charset: 'utf-8'),
    );
    Dio _dio2 = Dio(options);
    /// 统一添加身份验证请求头
//    _dio2.interceptors.add(AuthInterceptor());
//    /// 刷新Token
//    _dio2.interceptors.add(TokenInterceptor());
//    /// 打印Log
//    _dio2.interceptors.add(LoggingInterceptor());
//    /// 适配数据
//    _dio2.interceptors.add(AdapterInterceptor());
    try {
      response = await _dio2.download(urlPath, savePath,data: params,onReceiveProgress: (int count, int total){
        //进度
        print("下载文件进度-->$count $total");
        onProgress(count,total);
      });
      onSuccess();
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
//      formatError(e);
      onFail(e);
    }
//    return response.data;
  }
}