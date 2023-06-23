import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class MyGroceryList extends StatefulWidget {
  final List listData;
  const MyGroceryList({super.key,required this.listData});

  @override
  State<MyGroceryList> createState() => _MyGroceryListState();
}

class _MyGroceryListState extends State<MyGroceryList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('My Grocery List'),),
      body: ListView.builder(
        itemCount: widget.listData.length,
        itemBuilder: (context, index) {
          final groceryList = widget.listData[index];
          List<String> name=[];
          for (var data in groceryList) {
            name.add(data.strIngredient);
          }
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (builder){
                     return AlertDialog(
                       title: Text('Grocery List ${index + 1}',style:const TextStyle(fontSize: 14),),
                       content: SingleChildScrollView(
                         child: SizedBox(
                           height: 420,
                           width: 300,
                           child: GridView.builder(
                             shrinkWrap: true,
                             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                 maxCrossAxisExtent: 200,
                                 childAspectRatio: 2 / 2.7,
                                 crossAxisSpacing: 2,
                                 mainAxisSpacing: 2),
                             itemCount:name.length,
                             itemBuilder: (context, int index) {
                               return InkWell(
                                 onTap: () {
                                 },
                                 child: Card(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Column(
                                       children: [
                                         Image.network(
                                           "https://www.themealdb.com/images/ingredients/${name[index]}-Small.png",
                                           width: 100,
                                         ),
                                         Text(name[index],overflow: TextOverflow.ellipsis,)
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                         ),
                       ),

                     ) ;
                    });
                    },
                  child: ListTile(
                    title: Text('Grocery List ${index + 1}'),
                    subtitle: Text(name.join(',')),
                    trailing: IconButton(icon:const Icon(Icons.delete,color: Colors.red,),onPressed: (){
                      showDialog(context: context, builder: (builder){
                        return AlertDialog(
                          title:const Text("Are you sure?"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const Text("No")),
                            TextButton(onPressed: ()async{
                              final box = await Hive.openBox('groceries');
                              widget.listData.removeAt(index);
                              setState(() {
                                box.clear();
                                for (var item in widget.listData) {
                                  box.add(item);
                                }
                              });
                              box.close();
                              Navigator.pop(context);
                            }, child: const Text("Yes")),
                          ],
                        );
                      });
                    }),
                  ),
                ),
               const Divider()
              ],
            );

          }
      )
    );
  }
}
