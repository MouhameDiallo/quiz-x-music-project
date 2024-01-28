
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/provider/questionProvider.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String text;
  const MyButton({super.key,required this.color,required this.text});

  @override
  Widget build(BuildContext context) {
    final next = Provider.of<QuestionProvider>(context,listen: false);
    bool answer = text=='Vrai'?true:false;
    return  ElevatedButton(onPressed: (){next.next(answer);},style: ElevatedButton.styleFrom(backgroundColor: color), child: Text(text));
  }
}
