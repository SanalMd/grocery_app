import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocer_list_app/Model/ProfileModel.dart';
import 'package:hive/hive.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEdit = false;
  ProfileModel profileData = ProfileModel();
  final name=TextEditingController();
  final email=TextEditingController();
  final mobile=TextEditingController();
  final address = TextEditingController();
  @override
  void initState() {
    getProfileData();
    // TODO: implement initState
    super.initState();
  }
  getProfileData()async{
    final box = await Hive.openBox("groceries");
    profileData = box.get('userData');
    name.text = profileData.name??"";
    email.text = profileData.email??"";
    mobile.text = profileData.mobile??"";
    address.text = profileData.address??"";
    setState(() {

    });
    box.close();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(onPressed: ()async{

            if(isEdit==true) {
              final box = await Hive.openBox("groceries");
              box.put('userData', profileData);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated"),duration: Duration(milliseconds: 500),));
              box.close();
              isEdit=false;

              setState(() { });
            }else{
              isEdit = true;
              setState(() {

              });
            }
          }, child: Text(isEdit==true? "Update":"Edit"))),
      appBar: AppBar(title:const Text("Profile"),),
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
                        onChanged: (val){
                          profileData.name = val;
                        },
                        readOnly: !isEdit,
                        controller: name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4),
                          hintText: "Name"
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                        onChanged: (val){
                          profileData.email = val;
                        },
                        readOnly: !isEdit,
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4),
                          hintText: "Email"
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                        onChanged: (val){
                          profileData.mobile = val;
                        },
                        readOnly: !isEdit,
                        controller: mobile,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4),
                          hintText: "Mobile"
                        ),
                      ),
                      const SizedBox(height: 15,),
                      TextField(
                        onChanged: (val){
                          profileData.address = val;
                        },
                        readOnly: !isEdit,
                        controller: address,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4),
                          hintText: "Address",
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
