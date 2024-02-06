import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioButtonBar extends StatelessWidget {
  final String sound;
  const AudioButtonBar({super.key, required this.sound});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();
    bool isPlaying = false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Card(
        child: OverflowBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(child: const Icon(Icons.play_arrow), onPressed: () async {
              if(!isPlaying){
                await audioPlayer.play(UrlSource(sound));
                isPlaying = true;
              }
            }),
            TextButton(child: const Icon(Icons.pause), onPressed: () async {
              if(isPlaying){
                await audioPlayer.pause();
                isPlaying = false;
              }
            }),
            TextButton(child: const Icon(Icons.stop), onPressed: () async {
              if(isPlaying){
                await audioPlayer.stop();
                isPlaying = false;
              }
            }),
          ],
        ),
      ),
    );
  }
}
