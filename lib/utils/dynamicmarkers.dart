import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BusStop {
  final String name;
  final String description;
  final String imageAsset;
  final LatLng location;
  Color color;

  BusStop({
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.location,
    required this.color,
  });
}


List<BusStop> busStops = [
  BusStop(
    name: 'ENT Bus Stop',
    description: 'Entrance',
    imageAsset: 'images/logo.jpeg', // Example image URL
    location: LatLng(1.3329143792222058, 103.77742909276205), // Replace with actual coordinates
    color: Colors.red,
  ),
  BusStop(
    name: 'B23 Bus Stop',
    description: 'Block 23',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3339219201675242, 103.77574132061896), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'SPH Bus Stop',
    description: 'Sports Hall',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3350826567868576, 103.7754223503998), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'SIT Bus Stop',
    description: 'SIT University',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3343686930989717, 103.77435631203087), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'B44 Bus Stop',
    description: 'Block 44',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3329522845882348, 103.77145520892851), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'B37 Bus Stop',
    description: 'Block 37',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3327697559194817, 103.77323977064727), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'MAP Bus Stop',
    description: 'Makan Place',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3325776073001032, 103.77438270405088), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'HSC Bus Stop',
    description: 'Health Sciences',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.330028, 103.774623), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'LCT Bus Stop',
    description: 'Life Sciences',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3311533369747423, 103.77490110804173), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'B72 Bus Stop',
    description: 'Block 72',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.3312394356934057, 103.77644173403719), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'CLE Bus Stop',
    description: 'Clementi MRT',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.313434, 103.765811), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'KAP Bus Stop',
    description: 'King Albert Park MRT',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.335844, 103.783160), // Replace with actual coordinates
    color: Colors.blue,
  ),
  BusStop(
    name: 'OPPKAP Bus Stop',
    description: 'Opposite King Albert Park MRT',
    imageAsset: 'images/logo.jpeg',
    location: LatLng(1.336274, 103.783146), // Replace with actual coordinates
    color: Colors.blue,
  ),
  // Add more bus stops here
];

List<Marker> createMarkers(BuildContext context) {
  return busStops.map((busStop) {
    return Marker(
      point: busStop.location,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(busStop.name),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(busStop.description),
                    SizedBox(height: 10),
                    Image.network(busStop.imageAsset), // Display the image
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          CupertinoIcons.location_circle_fill,
          color: busStop.color,
          size: 25,
        ),
      ),
    );
  }).toList();
}