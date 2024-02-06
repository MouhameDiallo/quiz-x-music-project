import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/music_model.dart';
import '../../provider/music_provider.dart';

class SoundSample extends StatelessWidget {
  final int position;
  final List<Music> musics;
  const SoundSample({super.key, required this.position, required this.musics});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final itemProvider = Provider.of<MusicProvider>(
            context,
            listen: false);
        itemProvider.playPause(position);
      },
      onDoubleTap: () {
        final itemProvider = Provider.of<MusicProvider>(
            context,
            listen: false);
        itemProvider.stopAudio(position);
        Navigator.pushNamed(context, '/details', arguments: {
          'music': musics[position]
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                musics[position].artistPicture!),
          ),
          title: Text(musics[position].title!),
          subtitle:
          Text(musics[position].artistName!),
          trailing: musics[position].isPaused!
              ? const Icon(Icons.play_arrow)
              : const Icon(Icons.pause),
        ),
      ),
    );
  }
}
