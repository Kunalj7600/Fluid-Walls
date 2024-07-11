import 'package:fluid_walls/categories/abstract.dart';
import 'package:fluid_walls/categories/bikes.dart';
import 'package:fluid_walls/categories/landscapes.dart';
import 'package:fluid_walls/categories/space.dart';
import 'package:flutter/material.dart';
import 'package:fluid_walls/categories/nature.dart'; // Ensure this import is correct and Nature() is a valid widget
import 'package:fluid_walls/home.dart'; // Ensure this import is correct and Home() is a valid widget
import 'package:fluid_walls/modal/modal.dart'; // Ensure this import is correct based on your project structure
import 'package:fluid_walls/repo/repository.dart'; // Ensure this import is correct based on your project structure

class CustomAnimatedDrawer extends StatefulWidget {
  @override
  _CustomAnimatedDrawerState createState() => _CustomAnimatedDrawerState();
}

class _CustomAnimatedDrawerState extends State<CustomAnimatedDrawer> {
  Repository repo = Repository();
  late Future<List<Images>> imagesList;

  void getImagesBySearch({required String query}) {
    imagesList = repo.getImagesBySearch(query: query, pageNumber: 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.deepPurple),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()), // Navigate to Home
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.nature, color: Colors.green),
            title: Text('Nature'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NatureWallpapers()), // Navigate to Nature
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.landscape, color: Colors.teal),
            title: Text('Landscapes'),
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Landscapes()), // Navigate to Nature
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.palette, color: Colors.orange),
            title: Text('Abstract'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Abstract()), // Navigate to Nature
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.satellite, color: Colors.grey),
            title: Text('Space'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Space()), // Navigate to Nature
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bike_scooter, color: Color.fromARGB(255, 207, 18, 27)),
            title: Text('Bike'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bikes()), // Navigate to Nature
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text('About'),
            onTap: () {
              // Handle navigation to About page or any other action
            },
          ),
        ],
      ),
    );
  }
}
