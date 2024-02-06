import 'package:flutter/material.dart';
import 'package:quiz/widgets/audio_buttons.dart';

import '../models/music_model.dart';

class MusicDetails extends StatelessWidget {
  const MusicDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    Music music = args['music'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Détails",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                  music.artistPicture!),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            music.title!,
            style: const TextStyle(
              fontSize: 24.0,
              fontFamily: 'serif',
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(music.artistName!),
          const SizedBox(
            height: 30.0,
          ),
          const Divider(
            height: 3.0,
            indent: 65.0,
            endIndent: 65.0,
            thickness: 2.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          AudioButtonBar(sound: music.preview!,),
        ],
      ),
    );
  }

}
