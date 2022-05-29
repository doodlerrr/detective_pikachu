// @dart=2.9
import 'package:flutter/material.dart';
import 'package:detective_pikachu/model/sealItem.dart';

List<Seal> sortReset(List<Seal> a,int filterStatus,String inputText){
  if(inputText.isNotEmpty)
    a = findName(a,inputText,0,filterStatus);
  else if(filterStatus == 1)
    a = filter(a);
  return a;
}

List<Seal> filterReset(List<Seal> a,int sortStatus,String inputText){
  if(inputText.isNotEmpty)
    a = findName(a,inputText,sortStatus,0);
  else if(sortStatus == 1)
    a = ascending(a);
  else if(sortStatus == 2)
    a = descending(a);
  return a;
}

List<Seal> ascending(List<Seal> a){
  int len = a.length, cnt1, cnt2, index;
  Seal temp;
  for(cnt1=0; cnt1 < len-1; cnt1++){
    index = cnt1;
    for(cnt2 = cnt1 + 1; cnt2 < len; cnt2++){
      if(a[cnt2].sealName.compareTo(a[index].sealName) == -1)
        index = cnt2;
    }
    if(cnt1 != index){
      temp = a[cnt1];
      a[cnt1] = a[index];
      a[index] = temp;
    }
  }
  return a;
}

List<Seal> descending(List<Seal> a){
  int len = a.length, cnt1, cnt2, index;
  Seal temp;
  for(cnt1=0; cnt1 < len-1; cnt1++){
    index = cnt1;
    for(cnt2 = cnt1 + 1; cnt2 < len; cnt2++){
      if(a[cnt2].sealName.compareTo(a[index].sealName) == 1)
        index = cnt2;
    }
    if(cnt1 != index){
      temp = a[cnt1];
      a[cnt1] = a[index];
      a[index] = temp;
    }
  }
  return a;
}

List<Seal> filter(List<Seal> a){
  int len = a.length, cnt;
  for(cnt = 0; cnt < len; cnt++) {//인덱스를 지우면 리스트 길이가 달라짐
    if(a[cnt].status == false){
      a.removeAt(cnt);
      cnt--;
      len--;
    }
  }
  return a;
}

int findId(int id, List<Seal> a){
  int len = a.length, cnt, result = 0 ;
  for(cnt = 0; cnt < len; cnt++){
    if(a[cnt].id == id) {
      result = cnt;
    }
  }
  return result;
}

List<Seal> findName(List<Seal> a, String inputText, int sortStatus, int filterStatus){
  int len = a.length, cnt;
  for(cnt = 0; cnt < len;cnt ++){
    if(!a[cnt].sealName.contains(inputText)){
      a.removeAt(cnt);
      cnt--;
      len--;
    }
  }

  if(sortStatus == 1)
    a = ascending(a);
  else if(sortStatus == 2)
    a = descending(a);

  if(filterStatus == 1)
    filter(a);

  return a;
}