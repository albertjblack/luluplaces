import 'dart:io';
import 'package:flutter/material.dart';
import './../models/place.dart';
import './../models/place_location.dart';
import './../helpers/db_helper.dart';

class PlacesProvider with ChangeNotifier {
  String TABLE_NAME = "user_places";

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
    DbHelper.insert(TABLE_NAME, {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path
    });
  }

  Future<void> fetchSetPlaces() async {
    final dataList = await DbHelper.getData(TABLE_NAME);
    _items = dataList
        .map((e) => Place(
            id: e["id"],
            title: e["title"],
            location:
                PlaceLocation(latitude: 0.0, longitude: 0.0, address: null),
            image: File(e["image"])))
        .toList();
    notifyListeners();
  }
}
