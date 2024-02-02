import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quiz/provider/questionProvider.dart';
import 'package:quiz/services/questions.dart';
import 'package:quiz/widgets/MyButton.dart';
import 'package:http/http.dart' as http;

class App extends StatefulWidget {
  const App({super.key});

  //http://api.deezer.com/search?q=almudathir
  @override
  State<App> createState() => _AppState();
}
String search="";
List<dynamic> data2 = [];

class _AppState extends State<App> {
  List? rawdata;
  final AudioPlayer audioPlayer = AudioPlayer();
  String audioUrl = ""; // Remplacez par l'URL de la musique téléchargée
  late List<Question> questions = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Quiz", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              search = "almulk";
            });

          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: getQuestions(),
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot)
          {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const SpinKitSpinningLines(//Ceci est pour une dependance pour des progress circle plus jolies
                color: Colors.grey,
                size: 50.0,
              );
            }else
              {
                rawdata = snapshot.data;
                if(rawdata!=null){
                  for(Map data in rawdata!){
                    questions.add(Question(text: data["question"], answer: data["correct_answer"]));
                  }
                }
                if(data2.isNotEmpty){

                  Map dta = data2[0];
                  String audioPreview = dta["preview"];
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text(string),
                  // ));
                  audioUrl = audioPreview;
                }
                return Column(
                  children: [
                    Consumer<QuestionProvider>(builder: (context, value, _) {
                      value.questions = questions;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${value.score}/10',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 20.0),
                              child: Text(
                                value.questions[value.i].text,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyButton(color: Colors.green, text: 'Vrai'),
                        MyButton(color: Colors.red, text: 'False'),
                      ],
                    )
                  ],
                );
              }
          },
        ),
      ),
    );
  }
}

Future<List> getQuestions()async{
  String url='https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=boolean';
  var response = await http.get(Uri.parse(url));

  if(search!=""){
    String url2='http://api.deezer.com/search?q=$search';
    var response2 = await http.get(Uri.parse(url2));
    data2 = jsonDecode(response2.body)["data"];
  }


  Map data = jsonDecode(response.body);


  return data["results"];

  // Map data3;
  // for(data in data2){
  //   data3 = data;
  //   print(data3["question"]+' - - '+data3["correct_answer"]);
  // }
}

