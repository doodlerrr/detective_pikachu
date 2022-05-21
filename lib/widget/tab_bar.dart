import 'package:flutter/material.dart';
class BottomBar extends StatelessWidget {

  final double tabBarHeight = 60; // 탭 바 크기
  final double iconSize = 35; // 아이콘 크기

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: tabBarHeight,
        child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black12,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.my_location, size: iconSize,),),
            Tab(icon: Icon(Icons.local_mall, size: iconSize,)),
            Tab(icon: Icon(Icons.favorite_border, size: iconSize),),
            Tab(icon: Icon(Icons.person_outline, size: iconSize),),
          ],
        ),
      )
    );
  }
}