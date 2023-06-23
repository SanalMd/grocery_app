import 'package:flutter/material.dart';
import 'package:grocer_list_app/screens/splash.dart';
import 'package:hive_flutter/adapters.dart';

import 'Model/ProfileModel.dart';
import 'Model/recipe.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(MealsAdapter());
  Hive.registerAdapter(ProfileAdapter());
  await Hive.openBox('groceries');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groceries',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(title: 'Groceries'),
    );
  }
}


