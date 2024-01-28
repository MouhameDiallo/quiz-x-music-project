import 'package:flutter/foundation.dart';

import '../services/questions.dart';

class QuestionProvider extends ChangeNotifier{
  List<Question> questions = [];
  int i=0;
  int score=0;

  QuestionProvider(){
    i++;
  }
   void next(bool answer){

    String ans = answer?'True':'False';
    if(questions[i].answer.compareTo(ans)==0){
      score++;
    }
    i++;
    if(i==10) {
      i=0;
      score = 0;
    }
    notifyListeners();
   }
}