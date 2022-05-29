// @dart=2.9
import 'package:flutter/material.dart';

class Seal {
  int id;
  String imgPath;
  String sealName;
  String point;
  bool status = false;

  Seal({
    @required this.id,
    @required this.sealName,
    @required this.point,
    @required this.imgPath,
  });
}