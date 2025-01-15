import 'dart:ui';

import 'package:flutter/material.dart';

Color getMarkerColor(String markerName, int currentValue) {
  if (markerName == "ENT" && currentValue == 2) {
    return Colors.red;
  } else if (markerName == "B23" && currentValue == 3) {
    return Colors.red;
  } else if (markerName == "SPH" && currentValue == 1) {
    // SPH NOT A BUS STOP ? change later
    return Colors.red;
  } else if (markerName == "SIT" && currentValue == 4) {
    return Colors.red;
  } else if (markerName == "B44" && currentValue == 5) {
    return Colors.red;
  } else if (markerName == "B37" && currentValue == 6) {
    return Colors.red;
  } else if (markerName == "MAP" && currentValue == 7) {
    return Colors.red;
  } else if (markerName == "HSC" && currentValue == 8) {
    return Colors.red;
  } else if (markerName == "LCT" && currentValue == 9) {
    return Colors.red;
  } else if (markerName == "B72" && currentValue == 10) {
    return Colors.red;
  }
  // Default color for all other cases
  return Colors.blue[900]!;
}