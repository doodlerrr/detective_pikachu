import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {

  final String string;
  final String text;
  final String text1;

  InfoCard({required this.text,required this.string,required this.text1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
        child: ListTile(
          onTap: (){
            AlertDialog dialog = AlertDialog(
                content: Text(text1)
            );
            showDialog(context: context, builder: (BuildContext context) => dialog);
          },
          title: Text(
            text,
            style:  TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            string,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
