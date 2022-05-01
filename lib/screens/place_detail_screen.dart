import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './map_screen.dart';

import './../providers/places_provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place-detail";
  const PlaceDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<PlacesProvider>(context, listen: false)
        .items
        .firstWhere((e) => e.id == id);
    return Scaffold(
        appBar: AppBar(title: Text(selectedPlace.title)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  selectedPlace.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                selectedPlace.title + "\n\n" + selectedPlace.location.address!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => MapScreen(
                            initialLocation: selectedPlace.location)));
                  },
                  child: const Text("View on map"))
            ],
          ),
        ));
  }
}
