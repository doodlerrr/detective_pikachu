// @dart=2.9
import 'package:detective_pikachu/model/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:detective_pikachu/.env.dart';

class PlacesService {
  final key = googleAPIKey;
  String types1 = 'grocery_or_supermarket';
  String types2 = 'convenience_store';
  // List<String> types = ['convenience_store'];
  // 'grocery_or_supermarket' types = 'food' types = 'school'
  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=$types2&rankby=distance&key=$key'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}