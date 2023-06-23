import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocer_list_app/screens/groceries.dart';
import 'package:grocer_list_app/screens/my_grocery_list.dart';
import 'package:grocer_list_app/screens/profile.dart';
import 'package:grocer_list_app/screens/recipes.dart';
import 'package:grocer_list_app/screens/stores.dart';
import 'package:hive/hive.dart';
import '../Model/GroceriesModel.dart';
import '../Model/MealsModel.dart';
import '../Model/ProfileModel.dart';
import '../Model/StoresModel.dart';
import '../Model/recipe.dart';
import '../helpers/api.dart';
import '../helpers/common.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Groceries gData = Groceries();
  ModelMeals mealData = ModelMeals();
  StoresModel storeData = StoresModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          actions:  [
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>const Profile()));
                  },
                  child:const Icon(Icons.person)),
            )
          ],
          title: const Text("Groceries"),
          elevation: 10,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/gr.jpeg"),
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                  child: Button().roundButtonWithText("New List", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => GroceriesList(gData: gData)));
                  }, CupertinoIcons.add),
                ),
                Expanded(
                  child: Button().roundButtonWithText("My List", () async {
                    List retrievedData = await getGroceryData();
                    if (context.mounted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MyGroceryList(
                                    listData: retrievedData,
                                  )));
                    }
                  }, CupertinoIcons.square_list_fill),
                ),
                Expanded(
                  child: Button()
                      .roundButtonWithText("Stores", () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Stores(data: storeData,)));
                  }, Icons.store),
                ),
                Expanded(
                    child: Button().roundButtonWithText(
                        "Recipes", () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>Receipes(mealModel: mealData,)));
                    }, CupertinoIcons.list_bullet))
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Groceries",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        GroceriesList(gData: gData)));
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder<Groceries>(
                        future: API().getProducts(),
                        builder: (context, data) {
                          gData = data.data??Groceries();
                          return SizedBox(
                            height: 170,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.data?.grocery?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        data.data?.grocery?[index]
                                                    .strIngredient !=
                                                null
                                            ? Image.network(
                                                "https://www.themealdb.com/images/ingredients/${data.data?.grocery?[index].strIngredient}-Small.png",
                                                width: 120
                                        ) : const Card(),
                                        Text(
                                          data.data?.grocery?[index]
                                                  .strIngredient ??
                                              "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                    const SizedBox(height: 15),
                    const Text(
                      "Recipes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder(
                        future: API().getRecipes(),
                        builder: (context, data) {
                          mealData = data.data??ModelMeals();
                          return SizedBox(
                            height: 180,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data.data?.meals?.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      print(data.data?.meals?[index].toJson());
                                    },
                                    child: SizedBox(
                                      width: 130,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(8),
                                                        topLeft:
                                                            Radius.circular(8)),
                                                child: Image.network(
                                                  data.data?.meals![index]
                                                          .strMealThumb ??
                                                      "",
                                                  width: 120,
                                                )),
                                            Text(
                                              data.data?.meals?[index]
                                                      .strMeal ??
                                                  "",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        }),
                    const SizedBox(height: 15),
                    const Text(
                      "Stores",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder(
                        future: API().getStores(),
                        builder: (context, data) {
                          storeData = data.data??StoresModel();
                          print(data);
                          return SizedBox(
                            height: 120,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: data.data?.meals?.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                     // print(data.data?.meals?[index].toJson());
                                    },
                                    child: SizedBox(
                                      width: 100,
                                      child: Card(
                                        child: Column(
                                          children: [
                                            const Icon(Icons.store,color: Colors.black26,size: 80,),
                                            Text(
                                              data.data?.meals?[index]
                                                      .strArea ??
                                                  "",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        })
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<List<dynamic>> getGroceryData() async {
    final box = await Hive.openBox('groceries');
    List retrievedData = box.values.toList();
    if (retrievedData.isNotEmpty && retrievedData.last is ProfileModel) {
      retrievedData.removeLast();
    }
    box.close();
    return retrievedData;
  }

}
