import 'package:sport_record/gym_plan_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "GymPlanEntity") {
      return GymPlanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}