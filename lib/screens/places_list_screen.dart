import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './add_place_screen.dart';
import './../providers/places_provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = "/places";
  const PlacesListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Consumer<PlacesProvider>(
            child:
                const Center(child: Text("No places yet, start adding some!")),
            builder: (ctx, places, ch) => places.items.length <= 0
                ? ch!
                : ListView.builder(
                    itemCount: places.items.length,
                    itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(places.items[i].image)),
                          title: Text(
                            places.items[i].title,
                          ),
                          onTap: () {
                            // go to detail page
                          },
                        ))));
  }
}
