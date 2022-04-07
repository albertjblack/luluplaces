import 'dart:io';
import 'package:flutter/material.dart';
import './../models/place.dart';
import './../models/place_location.dart';

class PlacesProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Place> _items = [];
  List<Place> get items {
    // so we can work with a copy and never change _items
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(latitude: 0.0, longitude: 0.0, address: ""),
        image: image);
    _items.add(newPlace);
    notifyListeners();
  }
}
