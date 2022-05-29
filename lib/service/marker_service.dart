// @dart=2.9
import 'package:detective_pikachu/model/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

class MarkerService {

  List<Marker> getMarkers(List<Place> places) {

    var markers = List<Marker>();
    var random = new Random();

    places.forEach((place) {
      Marker marker = Marker(
        markerId: MarkerId(place.name),
        draggable: false,
        infoWindow: InfoWindow(
          title: '${place.name} (재고: ${random.nextInt(5)})',
          snippet:  place.vicinity,

        ),
        position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
      );
      markers.add(marker);
    });
    return markers;
  }
}