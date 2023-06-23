import 'package:hive/hive.dart';
part 'recipe.g.dart';

@HiveType(typeId: 0,adapterName: 'MealsAdapter')
class Meals {
  Meals({
    this.idIngredient,
    this.strIngredient,
    this.strDescription,
    this.strType,
  });

  Meals.fromJson(dynamic json) {
    idIngredient = json['idIngredient'];
    strIngredient = json['strIngredient'];
    strDescription = json['strDescription'];
    strType = json['strType'];
  }

  @HiveField(0)
  String? idIngredient;

  @HiveField(1)
  String? strIngredient;

  @HiveField(2)
  String? strDescription;

  @HiveField(3)
  dynamic strType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idIngredient'] = idIngredient;
    map['strIngredient'] = strIngredient;
    map['strDescription'] = strDescription;
    map['strType'] = strType;
    return map;
  }
}