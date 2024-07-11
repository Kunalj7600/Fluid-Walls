import 'package:fluid_walls/modal/splash.dart';
import 'package:fluid_walls/repo/scrollBehave.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: splash(),
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ));
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   scrollBehavior: CustomScrollBehaviour(),
    //   title: 'Fluid Walls',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const Home(),
    // );
  }
}



