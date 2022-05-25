// @dart=2.9
import 'package:detective_pikachu/model/location.dart';

class Geometry {
  final Location location;

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic,dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);


}