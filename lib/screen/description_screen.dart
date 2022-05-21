// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:detective_pikachu/model/pokemon.dart';
import 'package:detective_pikachu/service/geolocator_service.dart';

class Description extends StatefulWidget {
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description>{

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";
  PokeHub pokeHub = PokeHub();
  @override
  void initState(){
    super.initState();
    fetchData();
  }
  fetchData() async{
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
  }
  @override
  Widget build(BuildContext context){
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon
        .map((poke)=>Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
          ),
        )).toList(),
      ),
    );
  }
}