import 'package:flutter/material.dart';

class Button{
  roundButtonWithText(String? text, Function() onPress, IconData icon){
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20.0),
            primary: Colors.white, // Button color
          ),
          child: Icon(icon),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(text??"",style:const TextStyle(fontSize: 12),),
        )
      ],
    );
  }
}
