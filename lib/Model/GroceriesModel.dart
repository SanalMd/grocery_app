import 'recipe.dart';

class Groceries {
  Groceries({
       this.grocery,});

  Groceries.fromJson(dynamic json) {
    if (json['meals'] != null) {
      grocery = [];
      json['meals'].forEach((v) {
        grocery?.add(Meals.fromJson(v));
      });
    }
  }
  List<Meals>? grocery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (grocery != null) {
      map['meals'] = grocery?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}