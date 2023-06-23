import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:grocer_list_app/Model/ProfileModel.dart';
import 'package:grocer_list_app/screens/register.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  bool? isReg = false;
  @override
  void initState() {
    isRegistered();
    // TODO: implement initState
    super.initState();
  }
  isRegistered()async{
    final box = await Hive.openBox('groceries');
    ProfileModel data = box.get('userData');
    if(data.name?.isNotEmpty??false){
      isReg = true;
    }else{
      isReg = false;
    }
    box.close();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
            duration: 1500,
            splash: Image.asset('assets/logo.png'),
            nextScreen: isReg==false ? const Register() :const Home(),
            pageTransitionType: PageTransitionType.leftToRight,
            splashTransition: SplashTransition.scaleTransition,
            splashIconSize: 200,
            backgroundColor: Colors.white);
  }
}
