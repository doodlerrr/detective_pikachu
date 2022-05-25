// @dart=2.9
class Location{
  final double lat;
  final double lng;
  Location({this.lat, this.lng});

  Location.fromJson(Map<dynamic,dynamic> parsedJson)
      :lat = parsedJson['lat'],
        lng = parsedJson['lng'];


}