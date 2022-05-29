import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:detective_pikachu/model/sealItem.dart';
import 'package:detective_pikachu/service/functionData.dart';

enum Sort{ reset, as, de }
enum Filter{ reset, fa }

List<String> breadImage = [
  'images/bread/cake.png',
  'images/bread/cheese.png',
  'images/bread/cream.png',
  'images/bread/hot.png',
  'images/bread/melon.png',
  'images/bread/pie.png',
  'images/bread/roll.png'
];

List<Seal> sealImage = [
  Seal(id: 1, sealName: '이상해씨',point: '이상해씨다.', imgPath: 'images/seal/Bulbasaur.png'),
  Seal(id: 2, sealName: '캐터피',point: '캐터피다.', imgPath: 'images/seal/Caterpie.png'),
  Seal(id: 3,sealName: '파이리',point: '파이리다.', imgPath: 'images/seal/Charmander.png'),
  Seal(id: 4,sealName: '디그다',point: '디그다다.', imgPath: 'images/seal/Diglett.png'),
  Seal(id: 5,sealName: '두두',point: '두두다.', imgPath: 'images/seal/Doduo.png'),
  Seal(id: 6,sealName: '이브',point: '이브다.', imgPath: 'images/seal/Eevee.png'),
  Seal(id: 7,sealName: '냄새꼬',point: '냄새꼬다.', imgPath: 'images/seal/Gloom.png'),
  Seal(id: 8,sealName: '잉어킹',point: '잉어킹이다.', imgPath: 'images/seal/Magikarp.png'),
  Seal(id: 9,sealName: '뮤츠',point: '뮤츠다.', imgPath: 'images/seal/Mewtwo.png'),
  Seal(id: 10,sealName: '피카츄',point: '피카츄다.', imgPath: 'images/seal/Pikachu.png'),
  Seal(id: 11,sealName: '꼬렛',point: '꼬렛이다.', imgPath: 'images/seal/Rattata.png'),
  Seal(id: 12,sealName: '야도란',point: '야도란이다.', imgPath: 'images/seal/Slowbro.png'),
  Seal(id: 13,sealName: '잠만보',point: '잠만보다.', imgPath: 'images/seal/Snorlax.png'),
  Seal(id: 14,sealName: '꼬부기',point: '꼬부기다.', imgPath: 'images/seal/Squirtle.png')
];
List<Seal> viewImage = new List.empty(growable: true);

class SecondPage extends StatefulWidget{
  @override
  State<SecondPage> createState() {
    return _SecondPage();
  }
}

class _SecondPage extends State<SecondPage>{
  TextEditingController getname = TextEditingController();
  String inputText = '';
  int _currentPage = 0, sortStatus = 0, filterStatus = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        body: Center(
          child: SingleChildScrollView(
            child:Container(
                child: Center(
                    child: Column(
                        children:<Widget>[
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentPage = index;
                                });},
                            ),
                            items: breadImage.map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.asset(image,fit: BoxFit.fitHeight)
                                      )
                                  );},
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: breadImage.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    width: 8.0, height: 8.0,
                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentPage == i
                                          ? Color(0xff01a8dd)
                                          : Color.fromRGBO(0, 0, 0, 0.4),
                                    ),
                                  );
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 7, 10, 15),
                            child: TextFormField(
                              controller: getname,
                              decoration: const
                              InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFEEEEEE),
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search',
                                border: InputBorder.none,
                              ),
                              onChanged: (text){
                                setState(() {
                                  inputText = text;
                                  viewImage = findName([...sealImage], inputText, sortStatus, filterStatus);
                                });
                              },
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                PopupMenuButton(
                                    child: Container(
                                      width: 176, height: 40, color: Color(0xFFEEEEEE),
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:<Widget>[
                                            Text('Sort',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                            Icon(Icons.swap_vert, color: Colors.black),
                                          ]),
                                    ),
                                    onSelected: (Sort result){
                                      setState(() {
                                        if(result == Sort.reset){
                                          viewImage = sortReset([...sealImage], filterStatus, inputText);
                                          sortStatus = 0;
                                        }
                                        else if(result == Sort.as){
                                          viewImage = ascending([...viewImage]);
                                          sortStatus = 1;
                                        }
                                        else if(result == Sort.de){
                                          viewImage = descending([...viewImage]);
                                          sortStatus = 2;
                                        }
                                      });},
                                    offset: Offset(30,40),
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Sort>>[
                                      PopupMenuItem<Sort>(
                                          height: 30,
                                          value: Sort.reset,
                                          child: Text('초기화')
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem<Sort>(
                                          height: 30,
                                          value: Sort.as,
                                          child: Text('오름차순')
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem<Sort>(
                                          height: 30,
                                          value: Sort.de,
                                          child: Text('내림차순')
                                      )]
                                ),
                                PopupMenuButton(
                                    child: Container(
                                      width: 176, height: 40, color: Color(0xFFEEEEEE),
                                      child:Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:<Widget>[
                                            Text('Filter',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                            Icon(Icons.tune, color: Colors.black)
                                          ]),
                                    ),
                                    onSelected: (Filter result){
                                      setState(() {
                                        if(result == Filter.reset){
                                          viewImage = filterReset([...sealImage], sortStatus, inputText);
                                          filterStatus = 0;
                                        }
                                        else if(result == Filter.fa){
                                          viewImage = filter(viewImage);
                                          filterStatus = 1;
                                        }
                                      });},
                                    offset: Offset(-30,40),
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Filter>>[
                                      PopupMenuItem<Filter>(
                                          height: 30,
                                          value: Filter.reset,
                                          child: Text('초기화')
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem<Filter>(
                                          height: 30,
                                          value: Filter.fa,
                                          child: Text('좋아요')
                                      )
                                    ]),
                              ]),
                          SizedBox(
                              height: 270,
                              width: 400 ,
                              child:ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: viewImage.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
                                    width: 175,
                                    child: Column(
                                        children: <Widget>[
                                          Image.asset(viewImage[index].imgPath, fit:BoxFit.fitHeight),
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    viewImage[index].sealName,
                                                    style: TextStyle(fontWeight: FontWeight.bold,)
                                                ),
                                                if(viewImage[index].status == false)
                                                  IconButton(
                                                      icon: Icon(Icons.favorite_border),
                                                      onPressed: () {
                                                        setState(() {
                                                          viewImage[index].status = true;
                                                          sealImage[findId(viewImage[index].id,sealImage)].status = true;
                                                        });
                                                      }
                                                  )
                                                else if(viewImage[index].status == true)
                                                  IconButton(
                                                      icon: Icon(Icons.favorite),
                                                      onPressed: () {
                                                        setState(() {
                                                          viewImage[index].status = false;
                                                          sealImage[findId(viewImage[index].id,sealImage)].status = false;
                                                          if(filterStatus == 1)
                                                            viewImage = filter([...viewImage]);
                                                        });
                                                      }
                                                  )]
                                          ),
                                          Text(viewImage[index].point)
                                        ]),
                                  );
                                },
                              )
                          )
                        ])
                )
            ),
          ),
        ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewImage = [...sealImage];
  }
}