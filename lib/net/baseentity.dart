
class BaseEntity<T>{

  int status;
  String message;
  T data;

  BaseEntity(this.status, this.message, this.data);
}