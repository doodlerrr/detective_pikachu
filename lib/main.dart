// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:detective_pikachu/widget/tab_bar.dart';
import 'package:detective_pikachu/screen/location_screen.dart';
import 'package:detective_pikachu/service/geolocator_service.dart';
import 'package:detective_pikachu/model/place.dart';
import 'package:detective_pikachu/service/places_service.dart';
import 'package:detective_pikachu/model/favorite_list_models.dart';
import 'package:detective_pikachu/model/favorite_page_models.dart';
import 'package:detective_pikachu/screen/favorite_list.dart';
import 'package:detective_pikachu/screen/favorite_page.dart';
import 'package:detective_pikachu/model/favorite_place_page.dart';
import 'package:detective_pikachu/screen/favorite_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
        // place
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position,Future<List<Place>>>(
          update: (context,position,places){
            return (position != null)
                ? placeService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        ),

        Provider(create: (context) => FavoriteListModel(),),
        ChangeNotifierProxyProvider<FavoriteListModel, FavoritePageModel>(
          create: (context) => FavoritePageModel(),
          update: (context, favoritelist, favoritepage) {
            if (favoritepage == null)
              throw ArgumentError.notNull('favoritePage');
            favoritepage.favoritelist = favoritelist;
            return favoritepage;
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
                  FavoriteList(),
                  FavoritePage(),
                  Container(child: Center(child : Text('4'))),
                ],
              ),
              bottomNavigationBar: BottomBar(),
            )
        ),
      ),
    );
  }
}