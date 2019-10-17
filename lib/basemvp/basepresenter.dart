import 'baseview.dart';
/**
 * 基础逻辑处理类3
 */
class BasePresenter<V extends BaseView>{
   V mView;

  /**
   * 绑定view，一般在初始化中调用该方法
   *
   * @param view view
   */
   void attachView(V view) {
     print('${mView}--> 绑定view，一般在初始化中调用该方法');
    this.mView = view;
  }

  /**
   * 解除绑定view，一般在dispose中调用
   */

   void detachView() {
    print('${mView}-->解除绑定view，一般在dispose中调用');
    this.mView = null;
  }

  /**
   * View是否绑定
   *
   * @return
   */
   bool isViewAttached() {
    return mView != null;
  }
}