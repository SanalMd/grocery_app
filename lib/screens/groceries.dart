
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Model/GroceriesModel.dart';
import '../Model/recipe.dart';

class GroceriesList extends StatefulWidget {
  final Groceries gData;
  const GroceriesList({super.key, required this.gData});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}


class _GroceriesListState extends State<GroceriesList> {
  List<Meals> groceryList = [];
  List<Meals> filteredData = [];
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: groceryList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selected items: ${groceryList.length}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            groceryList.clear();
                            setState(() {});
                          },
                          child: const Text(
                            "Clear",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final box = await Hive.openBox('groceries');
                        await box.add(groceryList);
                        setState(() {});
                        groceryList=[];
                        box.close();
                        Navigator.pop(context);
                      },
                      child: const Text("Add selected items to your list"))
                ],
              ),
            )
          : null,
      appBar: AppBar(
        title: const Text('Groceries'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    filteredData.addAll(widget.gData.grocery!.where((item) =>
                        item.strIngredient
                            ?.toLowerCase()
                            .contains(val.toLowerCase()) ??
                        false));
                  });
                },
                controller: search,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(),
                    hintText: "Search for groceries"),
              ),
            ),
            SizedBox(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2.3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                itemCount: filteredData.isNotEmpty ? filteredData.length : 100,
                itemBuilder: (context, int index) {
                  List<Meals>? data = filteredData.isNotEmpty
                      ? filteredData
                      : widget.gData.grocery;
                  return InkWell(
                    onTap: () {
                      groceryList.add(widget.gData.grocery![index]);
                      setState(() {});
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            data?[index].strIngredient != null
                                ? Image.network(
                                    "https://www.themealdb.com/images/ingredients/${data?[index].strIngredient}-Small.png",
                                    width: 100,
                                  )
                                : const Card(),
                            Text(
                              data?[index].strIngredient ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                           const Text(
                              '₹100',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              'Info: energy (kilojoules), protein, total fat, saturated fat, total carbohydrates, sugars and sodium',
                              style: TextStyle(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
