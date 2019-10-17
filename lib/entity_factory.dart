import 'entity/runshop_entity.dart';
import 'entity/runshoptype_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "RunshoptypeEntity") {
      return RunshoptypeEntity.fromJson(json) as T;
    } else if (T.toString() == "RunshopEntity") {
      return RunshopEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}