import 'Meals.dart';

class GroceryByStoreModel {
  GroceryByStoreModel({
      this.meals,});

  GroceryByStoreModel.fromJson(dynamic json) {
    if (json['meals'] != null) {
      meals = [];
      json['meals'].forEach((v) {
        meals?.add(Meals.fromJson(v));
      });
    }
  }
  List<Meals>? meals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (meals != null) {
      map['meals'] = meals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}