// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:detective_pikachu/widget/tab_bar.dart';
import 'package:detective_pikachu/screen/location_screen.dart';
import 'package:detective_pikachu/service/geolocator_service.dart';
import 'package:detective_pikachu/model/place.dart';
import 'package:detective_pikachu/service/places_service.dart';
import 'package:detective_pikachu/screen/favorite_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:detective_pikachu/screen/second_screen.dart';
import 'package:detective_pikachu/screen/fourth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final locatorService = GeoLocatorService();
  final placeService = PlacesService();
  List<String> savedWords = List<String>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // place
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<Place>>>(
          update: (context,position,places){
            return (position != null)
                ? placeService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Detective Pikachu',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        /*
        initialRoute: '/',
        routes: {
          '/': (context) => FavoriteList(),
          '/favoritepage': (context) => FavoritePage(),
        },
        */

        home: DefaultTabController(
            length: 4,
            child: Scaffold(
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Location(),
                  SecondPage(),
                  FavoriteWordsRoute(favoriteItems: []),
                  FourthApp()
                ],
              ),
              bottomNavigationBar: BottomBar(),
            )
        ),
      ),
    );
  }
}