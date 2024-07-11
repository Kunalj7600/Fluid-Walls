import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluid_walls/categories/abstract.dart';
import 'package:fluid_walls/categories/bikes.dart';
import 'package:fluid_walls/categories/nature.dart';
import 'package:fluid_walls/categories/space.dart';
import 'package:fluid_walls/home.dart';
import 'package:fluid_walls/modal/about.dart';
import 'package:fluid_walls/modal/modal.dart';
import 'package:fluid_walls/repo/preview.dart';
import 'package:fluid_walls/repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Landscapes extends StatefulWidget {
  const Landscapes({super.key});

  @override
  State<Landscapes> createState() => _Landscapes();
}

class _Landscapes extends State<Landscapes> {
  Repository repo = Repository();
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  late Future<List<Images>> imagesList;
  int pageNumber = 1;

  void getImagesBySearch({required String query}) {
    imagesList = repo.getImagesBySearch(query: query, pageNumber: 1);
    setState(() {});
  }

  @override
  void initState() {
    // Initialize with nature wallpapers
    imagesList = repo.getImagesBySearch(query: "landscapes", pageNumber: pageNumber);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Fluid",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            Text(
              " Walls",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.green,
              ),
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: () {
                        getImagesBySearch(query: textEditingController.text);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z0-9]'),
                  ),
                ],
                onSubmitted: (value) {
                  getImagesBySearch(query: value);
                },
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: imagesList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong :("),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: snapshot.data!.asMap().entries.where((entry) => entry.key % 2 == 0).map((entry) {
                            return buildImageContainer(
                              context,
                              entry.value.imagePotraitPath,
                              entry.value.imageID,
                            );
                          }).toList(),
                        ),
                        Column(
                          children: snapshot.data!.asMap().entries.where((entry) => entry.key % 2 != 0).map((entry) {
                            return buildImageContainer(
                              context,
                              entry.value.imagePotraitPath,
                              entry.value.imageID,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              
              // minWidth: double.infinity,
              // padding: const EdgeInsets.symmetric(vertical: 20),
              // color: Colors.deepPurple,
              // textColor: Colors.white,
              onPressed: () {
                pageNumber++;
                imagesList = repo.getImagesBySearch(query: "landscapes", pageNumber: pageNumber);
                setState(() {});
              },
              child: const Text('Load More'),
            ),
          ],
        ),
      ),
      drawer: CustomAnimatedDrawer(),
    );
  }

  Widget buildImageContainer(BuildContext context, String imageUrl, int imageId) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewPage(
                imageId: imageId,
                imageUrl: imageUrl,
              ),
            ),
          );
        },
        child: Container(
          height: 400,
          width: 190,
          decoration: BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAnimatedDrawer extends StatefulWidget {
  @override
  _CustomAnimatedDrawerState createState() => _CustomAnimatedDrawerState();
}

class _CustomAnimatedDrawerState extends State<CustomAnimatedDrawer> {
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
                FadeRoute(page: Home()),  // Using FadeRoute for transition
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.nature, color: Colors.green),
            title: Text('Nature'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: NatureWallpapers()),  // Using FadeRoute for transition
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.landscape, color: Colors.teal),
            title: Text('Landscapes'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: Landscapes()),  // Using FadeRoute for transition
              );// Navigate to Landscapes page
            },
          ),
          ListTile(
            leading: Icon(Icons.palette, color: Colors.orange),
            title: Text('Abstract'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: Abstract()),);
            },
          ),
          ListTile(
            leading: Icon(Icons.satellite, color: Colors.grey),
            title: Text('Space'),
            onTap: () {
             Navigator.push(
                context,
                FadeRoute(page: Space()),  // Using FadeRoute for transition
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bike_scooter, color: Colors.red),
            title: Text('Bike'),
            onTap: () {
             Navigator.push(
                context,
                FadeRoute(page: Bikes()),  // Using FadeRoute for transition
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                FadeRoute(page: About()),);
            },
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}
