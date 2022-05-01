import 'dart:io';
import 'package:flutter/material.dart';
import './../models/place.dart';
import './../models/place_location.dart';
import './../helpers/db_helper.dart';
import './../helpers/location_helper.dart';

class PlacesProvider with ChangeNotifier {
  String TABLE_NAME = "user_places";

  // ignore: prefer_final_fields
  List<Place> _items = [];
  List<Place> get items {
    // so we can work with a copy and never change _items
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final placeLoc =
        PlaceLocation(latitude: 0.0, longitude: 0.0, address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: placeLoc,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert(TABLE_NAME, {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": placeLoc.latitude,
      "loc_lng": placeLoc.longitude,
      "address": placeLoc.address!
    });
  }

  Future<void> fetchSetPlaces() async {
    final dataList = await DbHelper.getData(TABLE_NAME);
    _items = dataList
        .map((e) => Place(
            id: e["id"],
            title: e["title"],
            location: PlaceLocation(
                latitude: e["loc_lat"],
                longitude: e["loc_lng"],
                address: e["address"]),
            image: File(e["image"])))
        .toList();
    notifyListeners();
  }
}
