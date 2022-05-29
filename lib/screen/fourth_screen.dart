import 'package:flutter/material.dart';
import 'package:detective_pikachu/widget/info_card.dart';

const name = "이름";
const teamname = "김민수";
const phonenumber = "휴대전화 번호";
const Email = "Email";
const email = "xxxxxxxxxxx";
const phone = "010-1234-5678";
const githubadress = "깃허브주소";
const adress = "www.github.com";
const AllName = "오윤지    ""    저우환위""        정태현";
const ALLPhone = "xxx-xxxx-xxxx    ""    xxx-xxxx-xxxx""        xxx-xxxx-xxxx";
const Allemail = "xxxxxxxxxxx    ""    xxxxxxxxxxx""        xxxxxxxxxxx";
const Allgithub = "www.github.com        ""www.github.com""        www.github.com";




class FourthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  '이름 혹은 별명',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              InfoCard(text: name, string: teamname,text1: AllName),
              InfoCard(text: phonenumber, string: phone,text1: ALLPhone),
              InfoCard(text: Email, string: email,text1: Allemail),
              InfoCard(text: githubadress, string: adress,text1: Allgithub),

            ],
          ),
        ),
      ),
    );
  }
}
