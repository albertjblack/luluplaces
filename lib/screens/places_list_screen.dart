//import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './add_place_screen.dart';
import './../providers/places_provider.dart';
import './place_detail_screen.dart';

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
        body: FutureBuilder(
          future: Provider.of<PlacesProvider>(context, listen: false)
              .fetchSetPlaces(),
          builder: (ctx, snap) =>
              snap.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<PlacesProvider>(
                      child: const Center(
                          child: Text("No places yet, start adding some!")),
                      builder: (ctx, places, ch) => places.items.isEmpty
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
                                    subtitle:
                                        Text(places.items[i].location.address!),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          PlaceDetailScreen.routeName,
                                          arguments: places.items[i].id);
                                    },
                                  ))),
        ));
  }
}
