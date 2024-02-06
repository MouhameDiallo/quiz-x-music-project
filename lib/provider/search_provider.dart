import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier{
  String search='';
  bool isListEmpty =true;

  void setSearch(String newValue){
    if(newValue!=''){
      search = newValue;
      isListEmpty = false;
      notifyListeners();
    }
  }
}