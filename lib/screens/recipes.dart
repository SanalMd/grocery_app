import 'package:flutter/material.dart';
import 'package:grocer_list_app/Model/GroceriesModel.dart';
import '../Model/MealsModel.dart';
import '../helpers/api.dart';
import 'groceries.dart';

class Receipes extends StatefulWidget {
  final ModelMeals mealModel;
  const Receipes({super.key,required this.mealModel});

  @override
  State<Receipes> createState() => _ReceipesState();
}


class _ReceipesState extends State<Receipes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                shrinkWrap: true,
                itemCount: widget.mealModel.meals?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      Groceries data = Groceries();
                      data = await API().getProducts();
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>GroceriesList(gData: data)));
                    },
                    child: SizedBox(
                      width: 100,
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
                                  widget.mealModel.meals![index]
                                      .strMealThumb ??
                                      "",
                                  width: 120,
                                )),
                            Text(
                              widget.mealModel.meals?[index]
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
                })
          ],
        ),
      ),
    );
  }
}
