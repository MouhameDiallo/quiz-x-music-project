import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier{
  String search='';

  void setSearch(String newValue){
    search = newValue;
    notifyListeners();
  }
}