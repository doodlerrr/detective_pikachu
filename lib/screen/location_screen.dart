// @dart=2.9
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:detective_pikachu/service/geolocator_service.dart';
import 'package:detective_pikachu/model/place.dart';
import 'package:detective_pikachu/main.dart';
import 'package:detective_pikachu/service/places_service.dart';
import 'package:detective_pikachu/model/location.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:detective_pikachu/service/marker_service.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:detective_pikachu/screen/favorite_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:detective_pikachu/.env.dart';
import 'package:detective_pikachu/model/place.dart';
import 'package:detective_pikachu/model/geometry.dart';

class Location extends StatefulWidget{
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>{
  List<String> savedWords = List<String>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();

  }
  @override
  Widget build(BuildContext context) {

    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final Marker _currentPosition = Marker(
      markerId: MarkerId('currentPosition'),
      infoWindow: InfoWindow(title:'origin'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
    );
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    //final List<Place> places = [];

    return FutureProvider(
      create:(context) => placesProvider,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'Pokemon',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Badge(
              badgeContent : Text(
                '${savedWords.length}',
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () => pushToFavoriteWordsRoute(context),
              ),
              badgeColor: Colors.black,
              position: BadgePosition.topEnd(top: 3, end: 2),
              animationType: BadgeAnimationType.scale,
            )
          ],
        ), 
          body: (currentPosition != null || currentPosition.latitude != null) ? Consumer<List<Place>>(
            builder: (_,places, __) {
              var markers = (places != null)
                  ? markerService.getMarkers(places)
                  : List<Marker>();
              return (places != null) ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                         target: (currentPosition.latitude != null)
                            ? LatLng(currentPosition.latitude,currentPosition.longitude)
                            : Center(child: CircularProgressIndicator(),),
                        zoom: 16.0,
                      ),
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      markers: Set<Marker>.of(markers),
                      polylines: _polylines,
                      onMapCreated: (GoogleMapController controller) {
                        void setPolylines() async {
                          PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                              googleAPIKey,
                              PointLatLng(
                                currentPosition.latitude,
                                currentPosition.longitude
                              ),
                              PointLatLng(
                                places[10].geometry.location.lat,
                                places[10].geometry.location.lng
                              )
                          );
                          if (result.status == 'OK') {
                            result.points.forEach((PointLatLng point) {
                              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
                            });
                            setState(() {
                              _polylines.add(
                                Polyline(
                                  width: 10,
                                  polylineId: PolylineId('polyLine'),
                                  color: Colors.orange,
                                  points: polylineCoordinates
                                )
                              );
                            });
                          }
                        }
                        setPolylines();
                      },
                      //{if(_currentPosition != null) _currentPosition},
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height/3,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (context ,index){
                              String word = places[index].name;
                              bool isSaved = savedWords.contains(word); // true/false

                              return FutureProvider(
                                  create: (context) => geoService.getDistance(
                                      currentPosition.latitude,
                                      currentPosition.longitude,
                                      places[index].geometry.location.lat,
                                      places[index].geometry.location.lng
                                  ),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(places[index].name),
                                      subtitle: Column(
                                        children: <Widget>[
                                          ( places[index].rating != null ) ? Row(
                                            children: <Widget>[
                                              RatingBarIndicator(
                                                rating: places[index].rating,
                                                itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                                                itemCount: 5,
                                                itemSize: 10.0,
                                                direction: Axis.horizontal,
                                              )
                                            ],
                                          ) : Row() ,
                                          Consumer<double>(
                                            builder:  (context, meters, widget){
                                              return (meters != null)
                                                  ? Text('${places[index].vicinity} \u00b7 ${(meters/1609).round()} mils')
                                                  : Container();
                                            },
                                          )
                                        ],
                                      ),
                                      trailing: Container(
                                          child: Row(
                                            mainAxisSize : MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.directions),
                                                color:  Theme.of(context).primaryColor,
                                                onPressed: (){
                                                  _launchMapsUrl(places[index].geometry.location.lat, places[index].geometry.location.lng);
                                                  },
                                              ),
                                              IconButton(
                                                icon :(isSaved)
                                                    ? Icon(Icons.favorite)
                                                    : Icon(Icons.favorite_border),
                                                onPressed: () {
                                                  setState(() {
                                                    if (isSaved) {
                                                      savedWords.remove(word);
                                                    } else {
                                                      savedWords.add(word);
                                                    }
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                      ),
                                    ),
                                  )
                              );
                            },
                          ),
                        )
                    ),
                  ],
                ),
              ) : Center(child: CircularProgressIndicator(),);
            },
          ): Center(child: CircularProgressIndicator(),)
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async{
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
      throw 'Could not launch $url';
    }
  }

  Future pushToFavoriteWordsRoute(context) {
    return Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => FavoriteWordsRoute(favoriteItems: savedWords))
    );
  }
}