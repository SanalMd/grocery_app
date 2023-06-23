class Meals {
  Meals({
      this.strArea,});

  Meals.fromJson(dynamic json) {
    strArea = json['strArea'];
  }
  String? strArea;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strArea'] = strArea;
    return map;
  }

}