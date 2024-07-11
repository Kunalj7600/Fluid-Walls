import 'dart:async';

import 'package:fluid_walls/home.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splash();  
}

class _splash extends State<splash> {

  @override
  
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
     });
  }


  Widget build(BuildContext){
    return Scaffold(
      body: SizedBox(
        height: 11100,
        child: Image.asset('lib/assets/images/Splash.jpg'),
      )
    );
  }
  
}