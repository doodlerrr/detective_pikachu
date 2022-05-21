import 'package:flutter/material.dart';
import 'package:detective_pikachu/screen/location_screen.dart';
import 'package:detective_pikachu/widget/tab_bar.dart';


class Favorite extends StatefulWidget{
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite>{

  BottomBar tab = BottomBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('찜한 스토어',style: TextStyle(fontSize: 30)),
      ),
      body:Center(
        child: Container(
          color: Colors.white,
          child: Row(
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: (){
        },
        child: Text('찜하러 가기', style: TextStyle(fontSize: 20,),),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.center,
          primary: Colors.yellow,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
          fixedSize: Size(MediaQuery.of(context).size.width*0.95,MediaQuery.of(context).size.height/12),
        ),
      ),


    );
  }
}