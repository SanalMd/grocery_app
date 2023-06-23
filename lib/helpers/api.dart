import 'dart:convert';
import 'package:grocer_list_app/Model/GroceryByStoreModel.dart';
import 'package:grocer_list_app/Model/MealsModel.dart';
import 'package:http/http.dart' as http;
import '../Model/GroceriesModel.dart';
import '../Model/StoresModel.dart';

class API{
  Future<Groceries> getProducts()async {
    var url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/list.php?i=list');
    final response = await http.get(url);
   // print(response.body);
    Groceries model = Groceries();
    model = Groceries.fromJson(jsonDecode(response.body));
    return model;
  }
  Future<ModelMeals> getRecipes()async {
    var url = Uri.parse(
         'https://www.themealdb.com/api/json/v1/1/search.php?f=c');
    var response = await http.get(url);
    ModelMeals model = ModelMeals(meals: []);
    model = ModelMeals.fromJson(jsonDecode(response.body));
    return model;
  }
  Future<StoresModel> getStores()async {
    var url = Uri.parse('https://www.themealdb.com/api/json/v1/1/list.php?a=list');
    var response = await http.get(url);
    StoresModel model = StoresModel(meals: []);
    model = StoresModel.fromJson(jsonDecode(response.body));
    return model;
  }
  Future<GroceryByStoreModel> getGroceryByStore(String text)async {
    var url = Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?a=$text');
    var response = await http.get(url);
    GroceryByStoreModel model = GroceryByStoreModel(meals: []);
    model = GroceryByStoreModel.fromJson(jsonDecode(response.body));
    print(model.toJson());
    return model;
  }
}
