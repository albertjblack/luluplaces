import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String?
      _previewImageUrl; // store a link to the image of the location it shows
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
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
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                label: const Text("Current location")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text("Location on map"))
          ],
        )
      ],
    );
  }
}
