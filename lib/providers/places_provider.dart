import 'package:flutter/material.dart';
import './../models/place.dart';

class PlacesProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Place> _items = [];
  List<Place> get items {
    // so we can work with a copy and never change _items
    return [..._items];
  }
}
