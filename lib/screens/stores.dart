import 'package:flutter/material.dart';
import 'package:grocer_list_app/Model/GroceriesModel.dart';
import '../Model/StoresModel.dart';
import '../helpers/api.dart';
import 'groceries.dart';

class Stores extends StatefulWidget {
  final StoresModel data;
  const Stores({super.key,required this.data});

  @override
  State<Stores> createState() => _StoresState();
}


class _StoresState extends State<Stores> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stores'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 180,
                    childAspectRatio: 2 / 1.8,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),
                shrinkWrap: true,
                itemCount: widget.data?.meals?.length,
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
                            const Icon(Icons.store,color: Colors.black26,size: 80,),
                            Text(
                              widget.data?.meals?[index]
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
                })
          ],
        ),
      ),
    );
  }
}
