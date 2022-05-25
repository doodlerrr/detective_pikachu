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

class Location extends StatefulWidget {
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>{

  bool like = false;
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

    return FutureProvider(
      create:(context) => placesProvider,
      child: Scaffold(
          body: (currentPosition != null || currentPosition.latitude != null)
              ? Consumer<List<Place>>(
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
                        zoom:16.0,
                      ),
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      markers: Set<Marker>.of(markers),
                      //{if(_currentPosition != null) _currentPosition},
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height/3,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: (context,index){
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
                                      trailing: IconButton(
                                        icon: Icon(Icons.directions),
                                        color:  Theme.of(context).primaryColor,
                                        onPressed: (){
                                          _launchMapsUrl(places[index].geometry.location.lat, places[index].geometry.location.lng);
                                        },
                                      ),

                                      /*ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.white,
                                              shadowColor: Colors.white,
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                like = !like;
                                              });
                                              },
                                            child:(like == false)
                                                ? Icon(Icons.favorite_border, color: Colors.black,)
                                                : Icon(Icons.favorite, color:Colors.black,),
                                          ),*/
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

}