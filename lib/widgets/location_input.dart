import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './../helpers/location_helper.dart';
import './../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput({required this.onSelectPlace, Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl; // store location img link

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    try {
      final mapUrl = LocationHelper.getLocationPreview(
          latitude: locData.latitude!, longitude: locData.longitude!);
      setState(() {
        _previewImageUrl = mapUrl;
      });
    } catch (e) {
      return;
    }
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    // using a future because once screen is popped we can return data and listen to that with then or awaiting
    final LatLng selectedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(isSelecting: true)));
    if (selectedLocation.latitude < 0.001) {
      return;
    }
    // logic
    try {
      final mapUrl = LocationHelper.getLocationPreview(
          latitude: selectedLocation.latitude,
          longitude: selectedLocation.longitude);
      setState(() {
        _previewImageUrl = mapUrl;
      });
    } catch (e) {
      return;
    }

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          height: 150,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  "No location chosen.",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ), // from a google api that creates image on the fly
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Current location")),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text("Location on map"))
          ],
        )
      ],
    );
  }
}
