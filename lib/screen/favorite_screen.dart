// @dart=2.9
import 'package:flutter/material.dart';

class FavoriteWordsRoute extends StatelessWidget {
  final List<String> favoriteItems;
  const FavoriteWordsRoute({Key key, @required this.favoriteItems})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        flexibleSpace: Container(
          color: Colors.white10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  찜한 스토어 ',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left ,
              ),
              Text(
                '  현재 찜한 스토어 ${favoriteItems.length}개',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),

      body: ( favoriteItems.length != 0 ) ? ListView.separated(
        itemCount: favoriteItems.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) => ListTile(
          leading: Icon(Icons.local_mall, size: 50,),
          title: Text(favoriteItems[index]),
          subtitle: Text(' 안녕하세요. ${favoriteItems[index]} 입니다. '),

        ),
      ) : Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/no.png',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Text(
                  '찜한 가게가 없어요',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '자주 찾는 가게를 찜해보세요',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
      ),
      floatingActionButton: ( favoriteItems.length != 0 )
          ? FloatingActionButton.extended(
              label: Text(
                '                   가게 더 찜하러 가기                    ',
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              onPressed: (){
              },
          )
          : FloatingActionButton.extended (
              label: Text(
                '                       찜하러 가기                     ',
                style: TextStyle(fontSize: 17),

              ),
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              onPressed: (){

              },
      ),
    );
  }
}