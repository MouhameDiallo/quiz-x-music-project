
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz/models/music_model.dart';

class MusicProvider extends ChangeNotifier{
  List<Music> musics = [];
  int lastPosition = 0;
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playPause(int position) async {

    if(lastPosition!=position){
      musics[lastPosition].isPaused = true;
      await audioPlayer.stop();
      lastPosition = position;
    }

    audioPlayer.onPlayerComplete.listen((event) {
      print('Lecture teminée');
      musics[lastPosition].isPaused = true;
      notifyListeners();
    });
    print('Element: ${audioPlayer.onPlayerComplete.first}');
    musics[position].isPaused = !musics[position].isPaused!;
    String audioUrl = musics[position].preview!;
    !musics[position].isPaused! ? await audioPlayer.play(UrlSource(audioUrl)): await audioPlayer.pause();
    print("Current system: ${musics[position].isPaused}");
    notifyListeners();
  }


}