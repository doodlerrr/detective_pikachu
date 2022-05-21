// @dart=2.9
import 'package:flutter/material.dart';
import 'package:detective_pikachu/widget/tab_bar.dart';
import 'package:detective_pikachu/screen/description_screen.dart';
import 'package:detective_pikachu/screen/location_screen.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:detective_pikachu/service/geolocator_service.dart';
import 'package:detective_pikachu/model/place.dart';
import 'package:detective_pikachu/service/places_service.dart';
import 'package:detective_pikachu/screen/favorite_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final locatorService = GeoLocatorService();
  final placeService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<Place>>>(
          update: (context,position,places){
            return (position != null)
                ? placeService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child:MaterialApp(
        title: 'Detective Pikachu',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Location(),
                  Description(),
                  Favorite(),
                  Container(child: Center(child: Text('4'))),
                ],
              ),
              bottomNavigationBar: BottomBar(),
            )
        ),
      ),
    );
  }
}
