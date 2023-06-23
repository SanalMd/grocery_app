import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocer_list_app/Model/ProfileModel.dart';
import 'package:grocer_list_app/screens/home.dart';
import 'package:grocer_list_app/screens/profile.dart';
import 'package:hive/hive.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final name=TextEditingController();
    final email=TextEditingController();
    final mobile=TextEditingController();
    final address = TextEditingController();
    ProfileModel profileData = ProfileModel();
    return Scaffold(
      bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(onPressed: ()async{
            final box = await Hive.openBox("groceries");
            box.put('userData', profileData);
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>Home()));
            box.close();
          }, child:const Text("Register"))),
      appBar: AppBar(title:const Text("Register"),),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  maxRadius: 60,
                  child: Icon(CupertinoIcons.person_alt_circle,size: 100,),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: name,
                        onChanged: (val){
                          profileData.name = val;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(4),
                            hintText: "Name"
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                        controller: email,
                        onChanged: (val){
                          profileData.email = val;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(4),
                            hintText: "Email"
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                        controller: mobile,
                        onChanged: (val){
                          profileData.mobile = val;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(4),
                            hintText: "Mobile"
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                        controller: address,
                        onChanged: (val){
                          profileData.address = val;
                        },
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4),
                          hintText: "Address",
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
