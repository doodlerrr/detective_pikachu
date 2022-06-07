// @dart=2.9
import 'package:geolocator/geolocator.dart';

class GeoLocatorService{

  final geolocator = Geolocator();

  Future<Position> getLocation() async {
    return await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location
    );
  }

  Future<double> getDistance(
      double startLatitude,
      double startLongitude,
      double endLatitude,
      double endLongitude) async {
    return await geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude );
  }

  Stream<Position> getCurrentLocation() {
    var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high, distanceFilter: 10
    );
    return geolocator.getPositionStream(locationOptions);
  }

  Future<Position> getInitialLocation() async {
    return geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }
}